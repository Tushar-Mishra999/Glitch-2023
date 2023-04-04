const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function live_mint(link, headless, retry = 0) {
    try {
        let browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
        let page = await browser.newPage();
        page.setUserAgent(utils.getUserAgent());
        await page.goto(link, { waitUntil: 'networkidle2' });
        // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
        await utils.autoscroll(page);
        let news;
        news = await page.evaluate(() => {
            return [...document.querySelector("#mainArea").querySelectorAll('p')].map(e => e.innerText).join(' ')
        });
        return news;
    } catch (e) {
        await browser.close()
        if (retry < 3) {
            return await live_mint(link, retry + 1);
        }
        return null;
    }
}

exports.live_mint = async function (link, headless) {
    return await live_mint(link, headless);
}