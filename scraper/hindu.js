const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function hindu (link, headless, retry = 0) {
    try {
    const browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
    page=await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await utils.autoscroll(page);
    let news;
    news=await page.evaluate(() => {
        return document.querySelector('[itemprop="articleBody"]').innerText.trim();
    });
    return news;
    } catch (e) {
        if (retry < 3) {
            return await hindu(link, retry + 1);
        }
        return null;
    }
}

exports.hindu = async function(link, headless) {
    return await hindu(link, headless);
}