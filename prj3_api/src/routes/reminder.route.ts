import express = require("express");
import reminderController = require("../controllers/reminder.controller");
import { auth } from "../middlewares/auth.middleware";
import { validateCreateReminderInfo } from "../validators/reminder.validator";

const router = express.Router();
router.post("/", auth, validateCreateReminderInfo, reminderController.create);
router.get("/", auth, reminderController.get);

export const reminderRoute = router;