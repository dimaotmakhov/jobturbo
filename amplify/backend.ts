import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { EventSourceMapping, StartingPosition } from "aws-cdk-lib/aws-lambda";
import { Stack } from "aws-cdk-lib";
import { Effect, Policy, PolicyStatement } from "aws-cdk-lib/aws-iam";
import { createLambdaErrorAlarm } from './alarms';
import { myDynamoDBRequestFunction } from './functions/dynamoDB-request-function/resource';
import { CfnApp } from 'aws-cdk-lib/aws-pinpoint';
// import { requestRepeatWeekly } from './jobs/request-repeat/resource'
import { jobListingHandler } from './data/job-listing-handler/resource';
import { preSignUp } from './auth/pre-sign-up/resource';

const backend = defineBackend({
  auth,
  data,
  myDynamoDBRequestFunction,
  // turn off function until app not reached its track
  // requestRepeatWeekly,
  jobListingHandler,
  preSignUp,
});

backend.preSignUp.resources.lambda.addToRolePolicy(
  new PolicyStatement({
    effect: Effect.ALLOW,
    actions: ['cognito-idp:ListUsers', 'cognito-idp:AdminLinkProviderForUser', 'cognito-idp:AdminCreateUser', 'cognito-idp:AdminSetUserPassword', 'cognito-idp:AdminUpdateUserAttributes'],
    resources: ["*"]
  })
);

// Create stack for all Lambda alarms
const lambdaAlarmsStack = backend.createStack('lambda-alarms');

// Add error alarms for each Lambda function
createLambdaErrorAlarm(lambdaAlarmsStack, 'DynamoDBRequestFunction', backend.myDynamoDBRequestFunction.resources.lambda);
// createLambdaErrorAlarm(lambdaAlarmsStack, 'RequestRepeatWeekly', backend.requestRepeatWeekly.resources.lambda);
createLambdaErrorAlarm(lambdaAlarmsStack, 'jobListingHandler', backend.jobListingHandler.resources.lambda);

const notificationsStack = backend.createStack("notifications-stack");

// create a Pinpoint app
const pinpoint = new CfnApp(notificationsStack, "Pinpoint", {
  name: "myPinpointApp",
});

// // create an IAM policy to allow interacting with Pinpoint
// const pinpointPolicy = new Policy(notificationsStack, "PinpointPolicy", {
//   policyName: "PinpointPolicy",
//   statements: [
//     new PolicyStatement({
//       actions: ["mobiletargeting:UpdateEndpoint", "mobiletargeting:PutEvents"],
//       resources: [pinpoint.attrArn + "/*"],
//     }),
//   ],
// });

// // apply the policy to the authenticated and unauthenticated roles
// backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(pinpointPolicy);
// backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(pinpointPolicy);

// create an IAM policy send push notifications
backend.myDynamoDBRequestFunction.resources.lambda.addToRolePolicy(
  new PolicyStatement({
    effect: Effect.ALLOW,
    actions: ["mobiletargeting:SendMessages"],
    resources: [pinpoint.attrArn + "/*"],
  })
);

// patch the custom Pinpoint resource to the expected output configuration
backend.addOutput({
  notifications: {
    amazon_pinpoint_app_id: pinpoint.ref,
    aws_region: Stack.of(pinpoint).region,
    channels: ['APNS'],
  },
});

backend.myDynamoDBRequestFunction.addEnvironment("PINPOINT_APP_ID", pinpoint.ref);

subscribeToTableEvents(backend, "Request", backend.myDynamoDBRequestFunction);

function subscribeToTableEvents(
  backend: any,
  tableName: string,
  backendFunction: any
) {
  const table = backend.data.resources.tables[tableName];
  const policy = new Policy(
    Stack.of(table),
    `MyDynamoDBFunction${tableName}StreamingPolicy`,
    {
      statements: [
        new PolicyStatement({
          effect: Effect.ALLOW,
          actions: [
            "dynamodb:DescribeStream",
            "dynamodb:GetRecords",
            "dynamodb:GetShardIterator",
            "dynamodb:ListStreams",
          ],
          resources: ["*"],
        }),
      ],
    }
  );
  backendFunction.resources.lambda.role?.attachInlinePolicy(policy);

  const mapping = new EventSourceMapping(
    Stack.of(table),
    `MyDynamoDBFunction${tableName}EventStreamMapping`,
    {
      target: backendFunction.resources.lambda,
      eventSourceArn: table.tableStreamArn,
      startingPosition: StartingPosition.LATEST,
      retryAttempts: 2
    }
  );

  mapping.node.addDependency(policy);
}
