const puppeteer = require("puppeteer");
const utils = require("./common.js");

const stocks=async function (retry = 0) {
    try {
        browser = await puppeteer.launch({ headless: false });
        page = await browser.newPage();
        // page.setUserAgent(utils.getUserAgent());
        await page.goto("https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%20100", { waitUntil: 'networkidle2' });
        let data = await page.evaluate(() => {
            return JSON.parse(document.querySelector('pre').innerText);
        });
        await browser.close();
        return data.data;
    } catch (err) {
        if (retry == 5){
            let page=await browser.newPage();
            await page.goto("https://nseindia.com", { waitUntil: 'domcontentloaded' });
            // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
            await utils.autoscroll(page);
            return stocks(++retry);
        }
        if (retry < 10) {
            await browser.close();
            console.log("Retrying...");
            return stocks(++retry);
        } else {
            await browser.close();
            console.log("Failed to fetch data!");
            return {};
        }
    }
}

stocks().then(data => console.log(data));

// exports.stocks = stocks;