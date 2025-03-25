import { defineFunction, secret } from "@aws-amplify/backend";

export const jobListingHandler = defineFunction({
    name: "job-listing-handler",
    entry: './handler.ts',
    timeoutSeconds: 100,
    environment: {
        BROWSER_WS_ENDPOINT: secret('BROWSER_WS_ENDPOINT'),
    }
})