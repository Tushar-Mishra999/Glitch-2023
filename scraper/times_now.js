const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function times_now(link, retry = 0) {
    try{
    const browser = await puppeteer.launch({ headless: false, timeout: 120000 });
    page = await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await utils.autoscroll(page);
    let news;
    news = await page.evaluate(() => {
        return [...document.querySelector("#progressBarContainer_0").querySelectorAll('._18840')].map(e => e.innerText).join(' ').trim();
    });
    return news;
    } catch (e) {
        if (retry < 3) {
            return await times_now(link, retry + 1);
        }
        return null;
    }
}

exports.times_now = async function (link) {
    return await times_now(link);
}
