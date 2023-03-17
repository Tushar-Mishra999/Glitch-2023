const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function economic_times(link, headless, retry = 0) {
    try {
    const browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
    page = await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    let news;
    news = await page.evaluate(() => {
        return document.querySelector('[class^="artText"]')?.innerText;
    });
    return news;
    } catch (e) {
        if (retry < 3) {
            return await economic_times(link, retry + 1);
        }
        return null;
    }
}

exports.economic_times = async function (link, headless) {
    return await economic_times(link, headless);
}
