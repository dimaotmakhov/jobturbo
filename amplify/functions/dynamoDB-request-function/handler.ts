import type { DynamoDBStreamHandler, DynamoDBRecord } from "aws-lambda";
import { Logger } from "@aws-lambda-powertools/logger";
import { env } from '$amplify/env/dynamoDB-request-function';
import { generateClient } from 'aws-amplify/data';
import { type Schema } from '../../data/resource';
import { Amplify } from "aws-amplify";
import { createJobListing, updateRequest } from "../graphql/mutations";
import { PinpointClient, SendMessagesCommand } from "@aws-sdk/client-pinpoint";
import { listJobListingByHash, listSettingByOwner } from "../graphql/queries";
import { RequestStatus } from "../graphql/API";
import { countryConfigs } from "./country-configs";

const logger = new Logger({
    logLevel: "INFO",
    serviceName: "dynamodb-stream-handler",
});

function isRequestFirstTime(record: DynamoDBRecord) {
    return record.eventName === "INSERT";
}

function isRequestRun(record: DynamoDBRecord) {
    return record.eventName === "MODIFY" && 
           record.dynamodb?.OldImage?.status?.S !== record.dynamodb?.NewImage?.status?.S && 
           record.dynamodb?.NewImage?.status?.S === "RUN";
}

const dbClient = generateClient<Schema>({
    authMode: "iam",
});

async function fetchGoogleJobs(country: string, position: string) {
    try {
        const apiKey = env.SERPAPI_KEY;
        const baseUrl = "https://serpapi.com/search.json";
        
        const countryConfig = countryConfigs[country.toLowerCase()] || countryConfigs['default'];
        
        const searchParams = {
            engine: "google_jobs",
            q: position,
            google_domain: countryConfig.googleDomain,
            // gl: country.toLowerCase(),
            hl: "en",
            api_key: apiKey,
        };

        logger.info(`Params: ${JSON.stringify(searchParams)}`);

        const params = new URLSearchParams(searchParams);

        const response = await fetch(`${baseUrl}?${params.toString()}`);

        const data = await response.json();
        
        return data.jobs_results || [];
    } catch (error) {
        console.error('Error fetching jobs from SerpApi:', error);
        throw error;
    }
}

export const handler: DynamoDBStreamHandler = async (event) => {
    for (const record of event.Records) {
        logger.info(`Processing record: ${record.eventID}`);
        logger.info(`Event: ${JSON.stringify(record)}`);

        if (isRequestFirstTime(record) || isRequestRun(record)) {
            const keywords = record.dynamodb?.NewImage?.keywords?.L?.map(k => k.S).join(', ') || '';
            const position = `${record.dynamodb?.NewImage?.position?.S} ${record.dynamodb?.NewImage?.location?.S}`;
            const country = record.dynamodb?.NewImage?.country?.S || '';

            const jobs = await fetchGoogleJobs(country, position);

            let newListingsCount = 0;

            // Process job listings from SerpApi response
            for (const job of jobs) {
                try {
                    const hash = `${record.dynamodb?.NewImage?.owner?.S}-${job.company_name}-${job.title}`;
                    
                    const existingListing = (await dbClient.graphql({
                        query: listJobListingByHash,
                        variables: { hash }
                    })).data.listJobListingByHash.items[0];

                    if (!existingListing) {
                        newListingsCount++;
                        const links = job.apply_options || [];
                        
                        await dbClient.graphql({
                            query: createJobListing,
                            variables: {
                                input: {
                                    hash: hash,
                                    companyName: job.company_name,
                                    position: job.title,
                                    logo: '',
                                    owner: record.dynamodb?.NewImage?.owner?.S,
                                    sortKey: "sortKey",
                                    url: job.share_link || '',
                                    requestId: record.dynamodb?.NewImage?.id?.S,
                                    jobPreview: job.description,
                                    links: links.map((link: any) => JSON.stringify({
                                        name: link.title,
                                        href: link.link
                                    })),
                                }
                            },
                        });
                        logger.info(`Created job listing: ${job.title} at ${job.company_name}`);
                    } else {
                        logger.info(`Skipping duplicate job listing: ${hash}`);
                    }
                } catch (e: unknown) {
                    logger.error(`Error processing job listing: ${JSON.stringify(e)}`);
                }
            }

            if (newListingsCount > 0) {
                const setting = (await dbClient.graphql({
                    query: listSettingByOwner,
                    variables: {
                        owner: record.dynamodb?.NewImage?.owner?.S || ''
                    },
                })).data.listSettingByOwner.items[0];

                const client = new PinpointClient({ region: env.AWS_REGION });

                const command = new SendMessagesCommand({
                    ApplicationId: env.PINPOINT_APP_ID,
                    MessageRequest: {
                        Addresses: {
                            ...(setting.deviceTokens && Array.isArray(setting.deviceTokens) ? 
                                setting.deviceTokens.reduce((acc, token) => {
                                    if (token) {
                                        acc[token] = {
                                            ChannelType: env.MODE === 'production' ? 'APNS' : 'APNS_SANDBOX'
                                        };
                                    }
                                    return acc;
                                }, {} as Record<string, { ChannelType: 'APNS' | 'APNS_SANDBOX' }>) : {})
                        },
                        MessageConfiguration: {
                            APNSMessage: {
                                Action: 'OPEN_APP',
                                Body: `You have ${newListingsCount} new job listings`,
                                Title: 'New Job Listings',
                                Priority: 'high',
                                SilentPush: false,
                            }
                        }
                    }
                });

                try {
                    const response = await client.send(command);
                    logger.info(`Push notification sent successfully ${JSON.stringify(response)}`);
                } catch (error) {
                    logger.error(`Error sending push notification ${JSON.stringify(error)}`);
                }

                logger.info(`Created ${newListingsCount} new listings.`);
            } else {
                logger.info(`No new listings created.`);
            }

            await dbClient.graphql({
                query: updateRequest,
                variables: {
                    input: {
                        id: record.dynamodb?.NewImage?.id?.S || '',
                        status: RequestStatus.STOP,
                    },
                },
            });
        }
    }
    logger.info(`Successfully processed ${event.Records.length} records.`);

    return {
        batchItemFailures: [],
    };
};

// Amplify configuration remains the same
Amplify.configure({
    API: {
        GraphQL: {
            endpoint: env.AMPLIFY_DATA_GRAPHQL_ENDPOINT,
            region: env.AWS_REGION,
            defaultAuthMode: "iam",
        },
    },
}, {
    Auth: {
        credentialsProvider: {
            getCredentialsAndIdentityId: async () => ({
                credentials: {
                    accessKeyId: env.AWS_ACCESS_KEY_ID,
                    secretAccessKey: env.AWS_SECRET_ACCESS_KEY,
                    sessionToken: env.AWS_SESSION_TOKEN,
                },
            }),
            clearCredentialsAndIdentityId: () => {
                /* noop */
            },
        },
    },
});