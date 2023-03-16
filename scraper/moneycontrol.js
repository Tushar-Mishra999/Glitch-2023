const utils = require('./common.js');

let moneycontrol = async function (browser, link) {
    page=await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await utils.autoscroll(page);
    let news;
    await page.evaluate(() => {
        if(document.querySelector('#readmorearticle')){
            document.querySelector('#readmorearticle').click();
        }
    });
    autoscroll(page);
    news=await page.evaluate(() => {
        return [...document.querySelector("#contentdata").querySelectorAll('p')].map(e=>e.innerText).join(' ').trim();
    });
    return news;
}