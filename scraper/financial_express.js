const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function financial_express (link, headless, retry = 0) {
    try{
    const browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
    page = await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await utils.autoscroll(page);
    let news;
    news = await page.evaluate(() => {
        return document.querySelector('#pcl-full-content').innerText;
    });
    return news;
    } catch (e) {
        if (retry < 3) {
            return await financial_express(link, retry + 1);
        }
        return null;
    }
}

exports.financial_express = async function(link, headless) {
    return await financial_express(link, headless);
}