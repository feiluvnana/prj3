import express = require("express");
import { upload } from "../middlewares/upload.middleware";
import controller = require("../controllers/document.controller")
import { validateGetDocumentInfo, validateUploadDocumentInfo, validateVoteDocumentInfo } from "../validators/document.validator";
import { auth } from "../middlewares/auth.middleware";

const router = express.Router();
router.post("/upload", auth, upload.single('document'), validateUploadDocumentInfo, controller.upload);
router.get("/", auth, validateGetDocumentInfo, controller.get);
router.get("/tags", auth, controller.getTags);
router.put("/vote", auth, validateVoteDocumentInfo, controller.vote);

export const documentRoute = router;