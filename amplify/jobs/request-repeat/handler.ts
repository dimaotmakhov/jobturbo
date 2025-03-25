import { generateClient } from "aws-amplify/api";
import type { EventBridgeHandler } from "aws-lambda";
import { listRequests } from "../../functions/graphql/queries";
import { updateRequest } from "../../functions/graphql/mutations";
import { RequestStatus } from "../../functions/graphql/API";
import { Schema } from "../../data/resource";
import { Amplify } from "aws-amplify";
// import { env } from "$amplify/env/request-repeat-weekly";

const dbClient = generateClient<Schema>({
  authMode: "iam",
});

export const handler: EventBridgeHandler<"Scheduled Event", null, void> = async (event) => {
  let nextToken: string | null = null;
  let allRequests: any[] = [];

  // Get current day of week (0 = Sunday, 1 = Monday, etc)
  const currentDay = new Date().getDay();
  const now = new Date().toISOString();
  const today = new Date().toISOString().split('T')[0]; // Get just the date part

  do {
    const result: any = await dbClient.graphql({
      query: listRequests,
      variables: {
        nextToken,
      },
    });

    if (!result.data) {
      console.error("No data returned from GraphQL query");
      return;
    }

    const dataListRequests = result.data;

    for (const item of dataListRequests.listRequests.items) {
      // Create mapping for day numbers to abbreviations
      const dayAbbreviations = ['su', 'mo', 'tu', 'we', 'th', 'fr', 'sa'];
      const currentDayAbbr = dayAbbreviations[currentDay];
      
      if (!item.repeat?.map((day: string) => day.toLowerCase()).includes(currentDayAbbr)) {
        console.log(`Repeat array does not include current day ${currentDayAbbr} ${JSON.stringify(item.repeat)}`);
        continue;
      }

      // Check if it has already run today
      if (item.lastRun?.startsWith(today)) {
        console.log(`Request ${item.id} already processed today`);
        continue;
      }

      if (item.lastRun && new Date(item.lastRun).getTime() > new Date().getTime() - 24 * 60 * 60 * 1000) {
        console.log('Time has not passed since last run');
        continue;
      }

      await dbClient.graphql({
        query: updateRequest,
        variables: {
          input: {
            id: item.id,
            lastRun: now,
            status: RequestStatus.RUN
          }
        },
      });
    }

    nextToken = dataListRequests.listRequests.nextToken;
  } while (nextToken);

  console.log("event", JSON.stringify(event, null, 2))
}

// Amplify.configure(
//   {
//       API: {
//           GraphQL: {
//               endpoint: env.AMPLIFY_DATA_GRAPHQL_ENDPOINT,
//               region: env.AWS_REGION,
//               defaultAuthMode: "iam",
//           },
//       },
//   },
//   {
//       Auth: {
//           credentialsProvider: {
//               getCredentialsAndIdentityId: async () => ({
//                   credentials: {
//                       accessKeyId: env.AWS_ACCESS_KEY_ID,
//                       secretAccessKey: env.AWS_SECRET_ACCESS_KEY,
//                       sessionToken: env.AWS_SESSION_TOKEN,
//                   },
//               }),
//               clearCredentialsAndIdentityId: () => {
//                   /* noop */
//               },
//           },
//       },
//   }
// );
