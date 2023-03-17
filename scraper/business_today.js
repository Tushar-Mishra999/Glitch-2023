const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function business_today (link, headless, retry = 0) {
    try{
    const browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
    page = await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await utils.autoscroll(page);
    let news;
    news = await page.evaluate(() => {
        return document.querySelector('.story-with-main-sec').innerText.split('Published')[0].trim();
    });
    return news;
    } catch (e) {
        if (retry < 3) {
            return await business_today(link, retry + 1);
        }
        return null;
    }
}

exports.business_today = async function(link, headless) {
    return await business_today(link, headless);
}