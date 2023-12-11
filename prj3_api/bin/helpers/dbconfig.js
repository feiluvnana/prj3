"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mysql = require("mysql2/promise");
function init() {
    return mysql.createPool({
        host: "localhost",
        user: "root",
        password: "",
        database: "prj3",
        multipleStatements: true
    });
}
module.exports.init = init;
