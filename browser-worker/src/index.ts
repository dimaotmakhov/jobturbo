import puppeteer from "@cloudflare/puppeteer";
import jobListing from "./job-listing";
const useProxy = require('puppeteer-page-proxy');

interface Env {
  MYBROWSER: Fetcher;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    let what = url.searchParams.get("what");
    // reqUrl = new URL(reqUrl).toString(); // normalize
	// https://www.google.com/search?q=Flutter%20Developer&udm=8&hl=en-US
	
    // Pick random session from open sessions
    let sessionId = await this.getRandomSession(env.MYBROWSER);
    let browser, launched;
    if (sessionId) {
      try {
        browser = await puppeteer.connect(env.MYBROWSER, sessionId);
      } catch (e) {
        // another worker may have connected first
        console.log(`Failed to connect to ${sessionId}. Error ${e}`);
      }
    }
    if (!browser) {
      console.log("No open sessions, launch new session");
      browser = await puppeteer.launch(env.MYBROWSER);
      launched = true;
    } else {
      console.log(`Found live browser ${browser.wsEndpoint()}`);
    }

    sessionId = browser.sessionId(); // get current session id

    // Do your work here
    const page = await browser.newPage();

	// Set proxy
	// await useProxy(page, 'http://brd-customer-hl_fd0a9f37-zone-web_unlocker1-country-us:j4i3iio5viyv@brd.superproxy.io:22225');
    let html = "";
    if (what === "job-listing") {
        html = await jobListing(page);
    } else {
      return new Response(
        `Not supported action: ${what}`,
        {
          status: 400,
          headers: {
            "content-type": "text/plain",
          },
        },
      );
    }

	// Remove proxy
	// await useProxy(page, null);

    // All work done, so free connection (IMPORTANT!)
    await browser.disconnect();

    return new Response(
      html,
      {
        headers: {
          "content-type": "text/html",
        },
      },
    );
  },

  // Pick random free session
  // Other custom logic could be used instead
  async getRandomSession(endpoint: puppeteer.BrowserWorker): Promise<string> {
    const sessions: puppeteer.ActiveSession[] =
      await puppeteer.sessions(endpoint);
    console.log(`Sessions: ${JSON.stringify(sessions)}`);
    const sessionsIds = sessions
      .filter((v) => {
        return !v.connectionId; // remove sessions with workers connected to them
      })
      .map((v) => {
        return v.sessionId;
      });
    if (sessionsIds.length === 0) {
      return;
    }

    const sessionId =
      sessionsIds[Math.floor(Math.random() * sessionsIds.length)];

    return sessionId!;
  },
};