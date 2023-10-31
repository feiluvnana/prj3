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
exports.ActivationKey = void 0;
const pool = require("../helpers/dbconfig").init();
class ActivationKey {
    constructor(email, activationKey, expireAt) {
        this.email = email;
        this.activationKey = activationKey;
        this.expireAt = expireAt;
    }
    create() {
        return __awaiter(this, void 0, void 0, function* () {
            return pool.query(`INSERT INTO activation_key VALUE (?, ?, ?)`, [this.email, this.activationKey, this.expireAt])
                .then((_) => this)
                .catch((err) => err);
        });
    }
    static read(key) {
        return __awaiter(this, void 0, void 0, function* () {
            return pool.query(`SELECT * FROM activation_key WHERE activation_key = ? AND expire_at > ?`, [key, Date.now()])
                .then((value) => value[0].length == 0
                ? null
                : new ActivationKey(value[0][0]["email"], value[0][0]["activation_key"], value[0][0]["expire_at"]))
                .catch((err) => err);
        });
    }
}
exports.ActivationKey = ActivationKey;
