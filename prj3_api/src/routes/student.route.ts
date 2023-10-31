import express = require("express");
import controller = require("../controllers/student.controller");

const router = express.Router();
router.post('/', controller.register);
router.get("/verify/:key", controller.verify);
router.post("/login", controller.login);

export const studentRoute = router;