import { Page } from "@cloudflare/puppeteer";

export default async function jobListing(page: Page) {
    // const url = "https://www.google.com/search?q=Flutter%20Developer&udm=8&hl=en-GB"
    let url = "https://www.google.com/search?q=Flutter+Developer&num=10&sca_esv=cede7393a1f5fe97&rlz=1C1ONGR_enDE1082DE1082&udm=8&biw=1920&bih=911&sxsrf=ADLYWIJG575U-h4EL3tAYRMgBzoN8INjMg%3A1732014489428&ei=mXE8Z-XnGamZi-gPnoGm8Qk&ved=0ahUKEwilmI3joOiJAxWpzAIHHZ6AKZ4Q4dUDCA8&uact=5&oq=Flutter+Developer&gs_lp=EhVnd3Mtd2l6LW1vZGVsZXNzLWpvYnMiEUZsdXR0ZXIgRGV2ZWxvcGVyMgoQABiwAxjWBBhHMgoQABiwAxjWBBhHMgoQABiwAxjWBBhHMgoQABiwAxjWBBhHMgoQABiwAxjWBBhHMgoQABiwAxjWBBhHMgoQABiwAxjWBBhHMgoQABiwAxjWBBhHMg0QABiABBiwAxhDGIoFMg0QABiABBiwAxhDGIoFSIsLUK0IWNoJcAN4AZABAJgB8gGgAfIBqgEDMi0xuAEDyAEA-AEBmAIDoAIImAMAiAYBkAYKkgcBM6AHuwY&sclient=gws-wiz-modeless-jobs&jbr=sep:0"
    url += "&hl=en-US";

    const response = await page.goto(url);
    const html = await response!.text();

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
    await page.goto(url, { waitUntil: "domcontentloaded", timeout: 60000 });
    try {
        await page.waitForSelector('#L2AGLb', {timeout: 10000});
        await page.click('#L2AGLb');
    } catch (error) {
        console.log('Cookie consent dialog not found or already accepted');
    }
    console.log("Navigated! Waiting for popup...");
    await page.waitForSelector('div.BIB1wf span.PcS0Hf');
    //   await interact(page);
    //   console.log("Parsing data...");
    //   const data = await parse(page);
    const element = await page.$('div.BIB1wf span.PcS0Hf');
    const jobDescription = await page.evaluate(el => el?.textContent, element);

    const links = await page.$$eval('a.nNzjpf-cS4Vcb-PvZLI-Ueh9jd-LgbsSe-Jyewjb-tlSJBe', els => els.map(el => {
        const name = el.textContent;
        const href = el.href;
        return { name, href };
    }));

    return JSON.stringify({ jobDescription, links });
}
