import express = require("express");
import { upload } from "../helpers/upload";
import controller = require("../controllers/document.controller")

const router = express.Router();
router.post("/", upload.single('file'), controller.upload);
// router.get("/", controller.get);
// router.get("/genre", controller.getGenre);

export const documentRoute = router;