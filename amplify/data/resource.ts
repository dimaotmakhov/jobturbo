import { type ClientSchema, a, defineData } from '@aws-amplify/backend';
import { myDynamoDBRequestFunction } from '../functions/dynamoDB-request-function/resource';
import { jobListingHandler } from './job-listing-handler/resource';
// import { requestRepeatWeekly } from '../jobs/request-repeat/resource';

const schema = a.schema({

  Setting: a.model({
    id: a.id().authorization(allow => [allow.owner().to(['create', 'read'])]),
    owner: a.string().authorization(allow => [allow.owner().to(['create', 'read'])]),
    deviceToken: a.string().authorization(allow => [allow.owner().to(["create", "update", "delete", "read"])]), // deprecated: 1.0.18
    deviceTokens: a.string().array()
  }).secondaryIndexes((index: any) => [
    index("owner"),
  ]).authorization((allow) => [
    allow.owner().to(["create", "update", /* "delete", "search", */ "get", "list"])
  ]),

  Request: a.model({
    id: a.id().authorization(allow => [allow.owner().to(['create', 'read', 'delete'])]),
    owner: a.string().authorization(allow => [allow.owner().to(['create', 'read', 'delete'])]),
    sortKey: a.string().required().default("sortKey"), // deprecated: 1.0.17
    country: a.string(),
    location: a.string(),
    position: a.string(),
    keywords: a.string().array(),
    repeat: a.string().array(),
    status: a.enum(['RUN', 'STOP']),
    lastRun: a.datetime(),
    createdAt: a.datetime(),
    updatedAt: a.datetime(),
    jobListings: a.hasMany('JobListing', 'requestId'),
  })
  .secondaryIndexes((index: any) => [
    index("sortKey").sortKeys(["createdAt"]), // deprecated: 1.0.17
    index("owner").sortKeys(["createdAt"]),
  ])
  .authorization((allow) => [
    allow.owner().to(["create", "update", "delete", /*"search", */ "get", "list"])
  ]),

  JobListing: a.model({
    id: a.id().authorization(allow => [allow.owner().to(['create', 'read'])]),
    owner: a.string().authorization(allow => [allow.owner().to(['create', 'read'])]),
    hash: a.string(),
    sortKey: a.string().required().default("sortKey"), // deprecated: 1.0.17
    companyName: a.string(),
    jobPreview: a.string(),
    position: a.string(),
    logo: a.string(),
    url: a.string(),
    keywords: a.string().array(),
    isApplied: a.boolean().default(false),
    status: a.enum(['APPLIED', 'NO_ANSWER', 'REJECTED', 'SUCCESSFUL']),
    links: a.json().array(),
    createdAt: a.datetime(),
    updatedAt: a.datetime(),
    isViewed: a.boolean().default(false),
    requestId: a.id(),
    request: a.belongsTo('Request', 'requestId'),
  })
  .secondaryIndexes((index: any) => [
    index("status").sortKeys(["createdAt"]),
    index("sortKey").sortKeys(["createdAt"]), // deprecated: 1.0.17
    index("owner").sortKeys(["createdAt"]),
    index("hash"),
  ])
  .authorization((allow) => [allow.owner()]),

  // mutations
  jobListingMutation: a
    .mutation()
    .arguments({
      id: a.string(),
    })
    .authorization(allow => [allow.authenticated()])
    .handler(a.handler.function(jobListingHandler))
    .returns(a.ref('JobListing'))
})
.authorization((allow) => [
  allow.resource(myDynamoDBRequestFunction),
  allow.resource(jobListingHandler),
  // allow.resource(requestRepeatWeekly),
]);

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
});
