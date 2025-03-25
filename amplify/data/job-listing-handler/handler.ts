import type { Schema } from '../resource'
import { env } from '$amplify/env/job-listing-handler';
import { Amplify } from "aws-amplify";
import { generateClient } from 'aws-amplify/data';
import { updateJobListing } from '../../functions/graphql/mutations';
import { getJobListing } from '../../functions/graphql/queries';
import puppeteer from 'puppeteer-core';
import * as htmlparser2 from "htmlparser2";
import * as APITypes from "../../functions/graphql/API";

const dbClient = generateClient<Schema>({
  authMode: "iam",
});

async function delay(page: any, ms: any) {
    await page.evaluate((ms: any) => new Promise(resolve => setTimeout(resolve, ms)), ms);
}

// function parse(html: string) {
//     let jobDescription = '';
//     let currentDepth = 0;
//     let targetDivDepth = -1;
//     let activeSpans = new Set<number>();  // Track depths of active target spans

//     const parser = new htmlparser2.Parser({
//         onopentag(name, attributes) {
//             currentDepth++;
            
//             // Check for our target div
//             if (name === 'div' && 
//                 attributes.class?.includes('BIB1wf') && 
//                 attributes.class?.includes('EIehLd') && 
//                 attributes.class?.includes('fHE6De') && 
//                 attributes.class?.includes('Emjfjd')) {
//                 targetDivDepth = currentDepth;
//             }
            
//             // Check for target spans - only if we're inside our target div
//             if (targetDivDepth !== -1 && 
//                 currentDepth > targetDivDepth && 
//                 name === 'span' && 
//                 attributes.class?.includes('PcS0Hf')) {
//                 activeSpans.add(currentDepth);
//             }
//         },
//         ontext(text) {
//             // Only collect text if we're inside both our target div and a target span
//             if (targetDivDepth !== -1 && 
//                 currentDepth > targetDivDepth && 
//                 activeSpans.size > 0) {
//                 const trimmed = text.trim();
//                 if (trimmed) {
//                     jobDescription += trimmed + ' ';
//                 }
//             }
//         },
//         onclosetag(name) {
//             // Remove this depth from active spans if it was one
//             activeSpans.delete(currentDepth);
            
//             // Reset target div tracking if we're closing it
//             if (currentDepth === targetDivDepth) {
//                 targetDivDepth = -1;
//                 activeSpans.clear();  // Clear any remaining spans
//             }
            
//             currentDepth--;
//         }
//     });

//     parser.write(html);
//     parser.end();

//     return jobDescription;
// }

async function run(url: string, position: string, country: string) {
    let browser;
    try {
        const wsUrl = new URL(env.BROWSER_WS_ENDPOINT);
        wsUrl.username = `${wsUrl.username.split('-country-')[0]}${country ? `-country-${country}` : ''}`;

        console.log(`Connecting to Scraping Browser... ${wsUrl.toString()}`);

        browser = await puppeteer.connect({
            browserWSEndpoint: wsUrl.toString(),
        });
        const page = await browser.newPage();
        
        // Set viewport to a reasonable size
        await page.setViewport({ width: 1280, height: 800 });
        
        // console.log(`Navigating to Google Jobs url: ${url}`);
        // await page.goto(url, {
        //     waitUntil: 'networkidle0'
        // });
        
        // // Wait for cookie consent dialog and click "Accept all" button
        // try {
        //     await page.waitForSelector('#L2AGLb', { timeout: 5000 });
        //     await page.click('#L2AGLb');
        //     console.log('Successfully clicked cookie consent button');
        //     // Wait a moment for the dialog to disappear
        //     await delay(page, 300);
        // } catch (error) {
        //     console.log('Cookie consent dialog not found or already accepted');
        // }

        // // Wait a moment for the modal to load
        // await page.waitForSelector('.BIB1wf', { timeout: 5000, visible: true });


        // const html = await page.content();

        console.log(`Navigating to ${url}`);
        const urlObj = new URL(url);
        urlObj.searchParams.delete("q");
        urlObj.searchParams.set("q", position);
        console.log(`Navigating to (with query) ${urlObj.toString()}`);

        await page.goto(urlObj.toString(), { waitUntil: "domcontentloaded", timeout: 60000 });
        try {
            await page.waitForSelector('#L2AGLb', {timeout: 10000});
            await page.click('#L2AGLb');
        } catch (error) {
            console.log('Cookie consent dialog not found or already accepted');
        }
        console.log("Navigated! Waiting for popup...");

        // await page.waitForSelector('div.BIB1wf div.NgUYpe'); // in all countries same

        const element = await page.waitForSelector('div.BIB1wf div.NgUYpe');
        const jobDescription = await element?.evaluate(el => el.textContent);

        const links = await page.$$eval('a.nNzjpf-cS4Vcb-PvZLI-Ueh9jd-LgbsSe-Jyewjb-tlSJBe', els => els.map(el => {
            const name = el.textContent;
            const href = el.href;
            return { name, href };
        }));

        // const links = await page.$$('nNzjpf-cS4Vcb-PvZLI-Ueh9jd-LgbsSe-Jyewjb-tlSJBe');

        // const linksText = await page.evaluate(links => links?.map(link => link?.textContent), links);
        // const linksHref = await page.evaluate(links => links?.map(link => link?.href), links);
        // console.log(linksText);


        console.log('Successfully fetched complete page content '+ jobDescription);
        console.log('Successfully fetched links '+ JSON.stringify(links));
        return { jobDescription, links };
    } catch (error) {
        console.error('Error during scraping:', error);
        throw error;
    } finally {
        if (browser) {
            await browser.close();
            console.log('Browser connection closed');
        }
    }
}

// @ts-ignore
export const handler: Schema["jobListingMutation"]["functionHandler"] = async (event, context) => {

    console.log(`event: ${JSON.stringify(event)}`);

    const jobListing = (await dbClient.graphql({
            query: getJobListing,
            variables: {
                id: event.arguments.id || ''
            },
    })).data.getJobListing;

    // If links are already present, return the job listing
    if (jobListing?.links && jobListing?.links.length > 0) {

        return jobListing;
    }

    const keywords = jobListing?.request?.keywords?.map(k => k).join(', ') || '';
    const position = `${jobListing?.request?.position} ${keywords} ${jobListing?.request?.location}`

    const { jobDescription, links } = await run(jobListing?.url || '', position, jobListing?.request?.country || 'de');

    console.log('Extracted job description:', jobDescription);
  
    type GeneratedMutation<InputType, OutputType> = string & {
        __generatedMutationInput: InputType;
        __generatedMutationOutput: OutputType;
      };
      
    try {
        const result = await dbClient.graphql({
            query: `mutation UpdateJobListing(
  $condition: ModelJobListingConditionInput
  $input: UpdateJobListingInput!
) {
  updateJobListing(condition: $condition, input: $input) {
    companyName
    createdAt
    hash
    id
    isApplied
    isViewed
    jobPreview
    keywords
    links
    logo
    owner
    position
    requestId
    sortKey
    status
    updatedAt
    url
    __typename
  }
}
` as GeneratedMutation<
  APITypes.UpdateJobListingMutationVariables,
  APITypes.UpdateJobListingMutation
>,
            variables: {
                input: {
                    // @ts-ignore
                    id: jobListing.id,
                    jobPreview: jobDescription,
                    links: links.map(link => JSON.stringify(link)),
                }
            },
        });
        
        return result.data.updateJobListing;

    } catch (error) {
        console.error('Error during updating jobListing:', error);
        throw error;
    }

};

Amplify.configure(
  {
      API: {
          GraphQL: {
              endpoint: env.AMPLIFY_DATA_GRAPHQL_ENDPOINT,
              region: env.AWS_REGION,
              defaultAuthMode: "iam",
          },
      },
  },
  {
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
  }
);
