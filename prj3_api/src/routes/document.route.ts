import express = require("express");
import { upload } from "../helpers/upload";
import controller = require("../controllers/document.controller")

const router = express.Router();
router.post("/", upload.single('document'), controller.upload);
router.get("/", controller.getDocuments);
router.get("/tags", controller.getTags);
router.put("/vote", controller.vote);

export const documentRoute = router;