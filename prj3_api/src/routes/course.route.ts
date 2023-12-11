import express = require("express");
import controller = require("../controllers/course.controller");
import { validateCreateCourseInfo } from "../validators/course.validator";
import { auth } from "../middlewares/auth.middleware";

const router = express.Router();
router.post("/", auth, validateCreateCourseInfo, controller.create);
router.get("/", auth, controller.get);

export const courseRoute = router;