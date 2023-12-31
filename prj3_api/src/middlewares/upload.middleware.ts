import multer = require('multer');
import path = require('path');
import { Student } from '../models/student.model';
import crypto = require('crypto');

var storage = multer.diskStorage({
    destination: async function (req, file, cb) {
        cb(null, path.join('F:', 'Desktop', 'my-crash-course', 'prj3', 'prj3_api', 'src', 'upload'));
    },
    filename: function (req, file, cb) {
        cb(null, crypto.createHash('md5').update(crypto.randomInt(1000000).toString().padStart(6, "0")).digest("hex") + "." + file.originalname.split(".")[file.originalname.split(".").length - 1]);
    },
})

export const upload = multer({
    fileFilter: async (req, file, cb) => {
        if (file.mimetype != "application/pdf"
            && file.mimetype != "application/msword"
            && file.mimetype != "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            && file.mimetype != "application/vnd.ms-excel"
            && file.mimetype != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
            cb(null, false);
            return;
        }
        cb(null, true);
    }, storage: storage
});