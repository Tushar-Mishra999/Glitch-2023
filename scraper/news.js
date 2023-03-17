const puppeteer = require('puppeteer');
const fs = require('fs');
const request = require('request');
const { env } = require('process');
const utils = require('./common');
const business_standard = require('./business_standard').business_standard;
const business_today = require('./business_today').business_today;
const economic_times = require('./economic_times').economic_times;
const financial_express = require('./financial_express').financial_express;
const hindu = require('./hindu').hindu;
const live_mint = require('./live_mint').live_mint;
const moneycontrol = require('./moneycontrol').moneycontrol;
const times_now = require('./times_now').times_now;
const indian_times = require('./indian_times').indian_times;


async function getNews(links, retry = 0) {
    let allNews = '';
    try {
        for (let i = 0; i < links.length; i++) {
            if (links[i].link.includes('indiatimes')) {
                let news = await indian_times(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('economictimes')) {
                let news = await economic_times(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('hindu')) {
                let news = await hindu(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('businesstoday')) {
                let news = await business_today(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('moneycontrol')) {
                let news = await moneycontrol(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('timesnow')) {
                let news = await times_now(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('livemint')) {
                let news = await live_mint(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('business-standard')) {
                let news = await business_standard(links[i].link);
                allNews += (' ' + news);
            }

            else if (links[i].link.includes('financialexpress')) {
                let news = await financial_express(links[i].link);
                allNews += (' ' + news);
            }
        }
        return allNews;
    } catch (e) {
        if (retry < 3) {
            return await getNews(links, retry + 1);
        }
        return allNews;
    }
}

async function searchNews(symbol, browser, retry = 0) {
    try {
        let page = await browser.newPage();
        await page.goto('https://www.google.com/search?q=' + symbol + '+news', { waitUntil: 'networkidle2' });
        await page.evaluate(() => {
            [...document.querySelector('[role="navigation"]').querySelectorAll('div')].find(e => e.innerText.includes('News')).querySelector('a').click();
            return null;
        });
        await page.waitForNavigation({ waitUntil: 'networkidle2' });
        let links = [];
        let count = await page.evaluate(() => {
            return document.querySelector('table').querySelectorAll('td').length - 2;
        });
        if ((count) > 1) {
            for (let i = 0; i < Math.floor((count) / 2); i++) {
                page.evaluate(() => {
                    document.querySelector("#pnnext").click();
                    return null;
                });
                await page.waitForNavigation({ waitUntil: 'networkidle2' });
                links = links.concat(await page.evaluate(() => {
                    return [...document.querySelector('#search').querySelectorAll('a')].map((e) => {
                        return { title: e.querySelector('[role="heading"]')?.innerText, link: e?.href, date: [...e.querySelectorAll('div')].find(e => e.style[0] == "bottom")?.innerText }
                    })
                }));
            }
        }
        return links;
    } catch (e) {
        if (retry < 3) {
            return await searchNews(symbol, browser, retry + 1);
        }
        return null;
    }
}

async function main() {
    const browser = await puppeteer.launch({ headless: false });
    let symbols = 'IEX';
    let links = await searchNews(symbols, browser);
    let news = await getNews(links);
    fs.writeFile(`${symbols}.txt`, news, function (err) {
        if (err) throw err;
        console.log('All news saved to file!');
    });
    await browser.close();
}

main();