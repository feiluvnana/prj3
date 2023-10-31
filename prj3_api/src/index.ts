import express = require('express');
import mongoose from 'mongoose';

import norres = require('./views/view_template');
import { studentRoute } from './routes/student.route';
import { init } from './helpers/db';
import { documentRoute } from './routes/document.route';

const port = 3802;
async function main() {
    await init();  

    const app = express();
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
    app.use(function (_, res, next) {
        res.header("Access-Control-Allow-Origin", "*");
        res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
        next();
    });
    app.use("/file/view", express.static("F:\\Desktop\\my-crash-course\\prj3\\prj3_api\\upload"));
    app.use("/student", studentRoute);
    app.use("/document", documentRoute);
    app.use((_, res) => {
        norres.res404_noroute(res);
    });
    app.listen(port, "localhost", () => {
        console.log(`Listening on port ${port}`);
    });
}

main();
