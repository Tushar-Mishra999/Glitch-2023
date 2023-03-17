const express = require("express");
const cron = require("node-cron");
const bodyParser = require('body-parser')
const news = require("./news.js");
const utils = require("./common.js");
const stocks=require("./nsedata.js");

const app = express();

app.use(bodyParser.urlencoded({
    extended: true,
    limit: '100mb',
    parameterLimit: 50000
}));

app.use(express.json());

app.post('/news', async (req, res) => {
    console.log('news')
    try {
        let headless = Boolean(eval(req.body.headless));
        let symbol = req.body.symbol;
        news.main(symbol, headless);
        res.send("Done");
    } catch (err) {
        console.log(err);
    }
});

app.get('/ua', async (req, res) => {
    try {
        res.send(utils.getUserAgent());
    } catch (err) {
        console.log(err);
    }
});

app.get('/stocks', async (req, res) => {
    try {
        res.send(stocks.stocks());
    } catch (err) {
        console.log(err);
    }
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});
