const utils = require('./common.js');
const puppeteer = require('puppeteer');

async function moneycontrol (link, headless, retry = 0) {
    try {
    const browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
    page=await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    // await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await utils.autoscroll(page);
    let news;
    await page.evaluate(() => {
        if(document.querySelector('#readmorearticle')){
            document.querySelector('#readmorearticle').click();
        }
    });
    await utils.autoscroll(page);
    news=await page.evaluate(() => {
        return [...document.querySelector("#contentdata").querySelectorAll('p')].map(e=>e.innerText).join(' ').trim();
    });
    return news;
    } catch (e) {
        if (retry < 3) {
            return await moneycontrol(link, retry + 1);
        }
        return null;
    }
}

exports.moneycontrol = async function(link, headless) {
    return await moneycontrol(link, headless);
}
