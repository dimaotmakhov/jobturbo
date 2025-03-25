import { defineFunction, secret } from "@aws-amplify/backend";

export const myDynamoDBRequestFunction = defineFunction({
    name: "dynamoDB-request-function",
    timeoutSeconds: 120,
    environment: {
        SERPAPI_KEY: secret('SERPAPI_KEY'),
        // @ts-ignore
        MODE: process.env.MODE,
    }
});