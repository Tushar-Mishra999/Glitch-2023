const { users } = require('./users.js');
const { proxies } = require('./proxies.js');
const request = require('request');


async function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function getUserAgent() {
    const x = Math.floor((Math.random() * users.length) + 1);
    return users[x];
}

async function getProxy() {
    const x = Math.floor((Math.random() * proxies.length) + 1);
    var rq = request.defaults({ 'proxy': proxies[x] });
    rq('https://www.google.com', function (error, response, body) {
        if (error) {
            console.log(error);
            return getProxy();
        }
        console.log('Proxy: ' + proxies[x]);
    });
    return proxies[x];
}

const autoscroll = async function (page) {
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

module.exports = {
    getUserAgent,
    getProxy,
    sleep,
    autoscroll
}