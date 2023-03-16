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

module.exports = {
    getUserAgent,
    getProxy,
    sleep,
}