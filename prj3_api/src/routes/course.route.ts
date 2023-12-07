import express = require("express");
import { upload } from "../helpers/upload";
import controller = require("../controllers/course.controller")

const router = express.Router();
router.post("/", controller.create);
router.get("/", controller.read);

export const courseRoute = router;