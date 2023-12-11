"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Account = void 0;
const pool = require("../helpers/dbconfig").init();
class Account {
    constructor(email, password, active) {
        this.email = email;
        this.password = password;
        this.active = active;
    }
    create() {
        return __awaiter(this, void 0, void 0, function* () {
            return pool.query(`INSERT INTO account VALUE (?, ?, ?)`, [this.email, this.password, this.active ? 1 : 0])
                .then(_ => this)
                .catch((err) => err);
        });
    }
    static read(email = "", password = "") {
        return __awaiter(this, void 0, void 0, function* () {
            return pool.query(`SELECT * FROM account WHERE email = ? AND password = ?`, [email, password])
                .then(value => value[0].length == 0
                ? null
                : new Account(value[0][0]["email"], value[0][0]["password"], value[0][0]["active"] == 1 ? true : false))
                .catch((err) => err);
        });
    }
    static readEmailOnly(email = "") {
        return __awaiter(this, void 0, void 0, function* () {
            return pool.query(`SELECT * FROM account WHERE email = ?`, [email])
                .then(value => value[0].length == 0
                ? null
                : new Account(value[0][0]["email"], value[0][0]["password"], value[0][0]["active"] == 1 ? true : false))
                .catch((err) => err);
        });
    }
    update(email) {
        return __awaiter(this, void 0, void 0, function* () {
            return pool.query(`UPDATE account SET email = ?, password = ?, active = ? WHERE email = ?`, [this.email, this.password, this.active ? 1 : 0, email])
                .then(_ => this)
                .catch((err) => err);
        });
    }
    delete() {
        return __awaiter(this, void 0, void 0, function* () {
            return pool.query(`DELETE FROM account WHERE email = ?`)
                .then(_ => null)
                .catch((err) => err);
        });
    }
}
exports.Account = Account;
