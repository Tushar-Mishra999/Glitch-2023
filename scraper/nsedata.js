const puppeteer = require("puppeteer");
const utils = require("./common.js");
const fs = require("fs");

async function stocks (browser = null, retry = 0) {
    try {
        browser = browser?browser:await puppeteer.launch({ headless: false });
        page = await browser.newPage();
        // page.setUserAgent(utils.getUserAgent());
        await page.goto("https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%20100", { waitUntil: 'networkidle2' });
        let data = await page.evaluate(() => {
            return JSON.parse(document.querySelector('pre').innerText);
        });
        await browser.close();
        let stocks = data.data.slice(1,6);
        fs.writeFileSync("../server/stocks.json", JSON.stringify(stocks));
        return 'done';
    } catch (err) {
        if (retry == 5){
            let page=await browser.newPage();
            await page.goto("https://www.nseindia.com/market-data/live-equity-market?symbol=NIFTY%20100", { waitUntil: 'domcontentloaded' });

            // // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
            await utils.autoscroll(page);
            return stocks(browser,++retry);
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

exports.stocks = async function () {
    return await stocks();
}