const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function indian_times(link, headless, retry = 0) {
    try {
    const browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
    page = await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await utils.autoscroll(page);
    let news;
    news = await page.evaluate(() => {
        return document.querySelector('div[data-articlebody]').innerText.split('READ NEXT')[0];
    });
    return news;
    } catch (e) {
        if (retry < 3) {
            return await indian_times(link, retry + 1);
        }
        return null;
    }
}

exports.indian_times = async function (link, headless) {
    return await indian_times(link, headless);
}