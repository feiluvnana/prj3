"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express = require("express");
const bodyParser = require("body-parser");
const norres = require("./views/view_template");
const account_1 = require("./routes/account");
const port = 3802;
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(function (_, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});
app.use("/account", account_1.accountRoute);
app.use((_, res) => {
    norres.res404_noroute(res);
});
app.listen(port, "localhost", () => {
    console.log(`Listening on port ${port}`);
});
