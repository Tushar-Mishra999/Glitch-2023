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

let getNews = async function (browser, symbol) {
    page=await browser.newPage();
    page.setUserAgent(utils.getUserAgent());
    await page.goto("https://bseindia.com");
    await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    await page.evaluate(() => {
        document.querySelector("#getquotesearch").click();
    });
    await page.keyboard.type(symbol, { delay: 300 });
    await page.evaluate((symbol)=>{
        [...document.querySelector("#ulSearchQuote").querySelectorAll('li')].find((e)=>{
            return e.querySelector('span').innerText.match(/\b\w+\b/g)[0]==symbol;
        }).querySelector('a').click()
    },symbol);
    await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    
}