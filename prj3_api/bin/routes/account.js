"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.accountRoute = void 0;
const express = require("express");
const controller = require("../controllers/account_controller");
const router = express.Router();
router.post('/', controller.register);
router.get("/verify/:key", controller.verify);
router.post("/login", controller.login);
exports.accountRoute = router;