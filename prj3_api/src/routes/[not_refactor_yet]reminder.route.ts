import express = require("express");
import reminderController = require("../controllers/reminder.controller");

const router = express.Router();
router.post("/", reminderController.create);
router.get("/", reminderController.get);

export const reminderRoute = router;