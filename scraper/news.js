const puppeteer = require('puppeteer');
const fs = require('fs');
const request = require('request');
const { env } = require('process');
const utils = require('./common');

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

async function searchNews(symbol, browser) {
    let page = await browser.newPage();
    await page.goto('https://www.google.com/search?q=' + symbol + '+news', { waitUntil: 'networkidle2' });
    await page.evaluate(() => {
        [...document.querySelector('[role="navigation"]').querySelectorAll('div')].find(e => e.innerText.includes('News')).querySelector('a').click();
        return null;
    });
    await page.waitForNavigation({ waitUntil: 'domcontentloaded' });
    let links = await page.evaluate(() => {
        return [...document.querySelector('#search').querySelectorAll('a')].map((e) => {
            return { title: e.querySelector('[role="heading"]')?.innerText, link: e?.href, date: [...e.querySelectorAll('div')].find(e => e.style[0] == "bottom")?.innerText }
        })
    });
}