const utils = require('./common.js');

let autoscroll = async function (page) {
    console.log('Scrolling page!');
    await page.evaluate(async () => {
        await new Promise((resolve, reject) => {
            var totalHeight = 0;
            var distance = 100;
            var timer = setInterval(() => {
                var scrollHeight = document.body.scrollHeight;
                window.scrollBy(0, distance);
                totalHeight += distance;

                if (totalHeight >= scrollHeight) {
                    clearInterval(timer);
                    resolve();
                }
            }, 150);
        });
    });
}

let getNews = async function (browser, link) {
    page=await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto(link, { waitUntil: 'networkidle2' });
    await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    autoscroll(page);
    let news;
    news=await page.evaluate(() => {
        return document.querySelector('[class^="artText"]')?.innerText;
    });
    return news;
}