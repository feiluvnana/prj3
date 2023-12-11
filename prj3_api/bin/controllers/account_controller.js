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
exports.login = exports.verify = exports.register = void 0;
const regex = require("../helpers/regex");
const views = require("../views/view_template");
const crypto = require("crypto");
const mailerconfig = require("../helpers/mailerconfig");
const account_model_1 = require("../models/account_model");
const activation_key_model_1 = require("../models/activation_key_model");
const authentication_token_model_1 = require("../models/authentication_token_model");
const register = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const email = req.body["email"];
    const password = req.body["password"];
    if (email == null || password == null || !regex.email.test(email) || !regex.password.test(password)) {
        views.res422(res);
        return;
    }
    let result = yield account_model_1.Account.read(email);
    if (!(result instanceof account_model_1.Account) && !(result === null)) {
        views.res500(res);
        return;
    }
    else if (result instanceof account_model_1.Account) {
        views.res200_duplicateemail(res);
        return;
    }
    let account = new account_model_1.Account(email, crypto.createHash("md5").update(password).digest("hex"), false);
    result = yield account.create();
    if (!(result instanceof account_model_1.Account) && !(result === null)) {
        views.res500(res);
        return;
    }
    const seed = crypto.randomInt(1000000).toString().padStart(6, "0");
    const key = crypto.createHash('md5').update(email + seed).digest("hex");
    let activationKey = new activation_key_model_1.ActivationKey(email, key, Date.now() + 600000);
    result = yield activationKey.create();
    if (!(result instanceof activation_key_model_1.ActivationKey) && !(result === null)) {
        views.res500(res);
        return;
    }
    mailerconfig.sendVerifyCode(email, `http://localhost:3802/account/verify/${activationKey.activationKey}`);
    views.res201_accountcreated(res);
});
exports.register = register;
const verify = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const key = req.params.key;
    if (key == null || !regex.activation_key.test(key)) {
        views.res422(res);
        return;
    }
    let result = yield activation_key_model_1.ActivationKey.read(key);
    if (!(result instanceof activation_key_model_1.ActivationKey) && !(result === null)) {
        views.res500(res);
        return;
    }
    else if (result === null) {
        views.res404_nokey(res);
        return;
    }
    result = yield account_model_1.Account.readEmailOnly(result.email);
    if (!(result instanceof account_model_1.Account) && !(result === null)) {
        views.res500(res);
        return;
    }
    else if (result === null) {
        views.res404_nokey(res);
        return;
    }
    console.log(result);
    let account = result;
    account.active = true;
    result = yield account.update(account.email);
    console.log(result);
    if (!(result instanceof account_model_1.Account) && !(result === null)) {
        views.res500(res);
        return;
    }
    views.res200_accountactivated(res);
});
exports.verify = verify;
const login = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const email = req.body.email;
    const password = req.body.password;
    console.log(req.body)
    if (email === null || password === null || !regex.email.test(email) || !regex.password.test(password)) {
        views.res422(res);
        return;
    }
    let result = yield account_model_1.Account.read(email, crypto.createHash('md5').update(password).digest("hex"));
    if (!(result instanceof account_model_1.Account) && !(result === null)) {
        views.res500(res);
        return;
    }
    else if (result === null) {
        views.res401_wronguserpass(res);
        return;
    }
    else if (!result.active) {
        views.res401_notactive(res);
        return;
    }
    let account = result;
    result = yield authentication_token_model_1.AuthenticationToken.read(email);
    if (!(result instanceof authentication_token_model_1.AuthenticationToken) && !(result === null)) {
        views.res500(res);
        return;
    }
    else if (result instanceof authentication_token_model_1.AuthenticationToken) {
        views.res200_loggedin(res, result.authenticationToken, result.expireAt);
        return;
    }
    let now = Date.now();
    let authenticationToken = new authentication_token_model_1.AuthenticationToken(account.email, crypto.createHash('sha1').update(account.email + now.toString()).digest("hex"), now + 1000 * 3600 * 24);
    result = authenticationToken.create();
    if (!(result instanceof authentication_token_model_1.AuthenticationToken) && !(result === null)) {
        views.res500(res);
        return;
    }
    views.res200_loggedin(res, authenticationToken.authenticationToken, authenticationToken.expireAt);
});
exports.login = login;
