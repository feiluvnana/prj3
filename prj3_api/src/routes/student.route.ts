import express = require("express");
import controller = require("../controllers/student.controller");
import { validateAuthInfo } from "../validators/student.validator";

const router = express.Router();
router.post('/register', validateAuthInfo, controller.register);
// router.get("/verify/:key", controller.verify);
router.post("/login", validateAuthInfo, controller.login);
// router.get("/", controller.get);
// router.put("/", controller.put);

export const studentRoute = router;