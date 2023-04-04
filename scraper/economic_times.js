const { users } = require('./users.js');
const puppeteer = require('puppeteer');

function getUserAgent() {
    const x = Math.floor((Math.random() * users.length) + 1);
    return users[x];
}

async function economic_times(link, headless, retry = 0) {
    try {
        const browser = await puppeteer.launch({ headless: headless, timeout: 120000 });
        page = await browser.newPage();
        page.setUserAgent(getUserAgent());
        await page.goto(link, { waitUntil: 'networkidle2' });
        let news;
        news = await page.evaluate(() => {
            return document.querySelector('[class^="artText"]')?.innerText;
        });
        await browser.close()
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
