import multer = require('multer');
import views = require('../views/view');
import path = require('path');
import { Student } from '../models/student.model';
import crypto = require('crypto');

var storage = multer.diskStorage({
    destination: async function (req, file, cb) {
        cb(null, path.join('F:', 'Desktop', 'my-crash-course', 'prj3', 'prj3_api', 'upload'));
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

        if (req.headers.authorization == null) {
            cb(null, false);
            return;
        }

        let auth = req.headers.authorization.split(" ");

        if (auth[0].toLowerCase() !== "bearer") {
            cb(null, false); return;
        }

        await Student.find({
            "token.value": auth[1], "token.expiredAt": {$gt: Date.now()}
        })
            .then(students => (students.length == 0) ? cb(null, false) : cb(null, true))
            .catch(err => cb(null, false));
    }, storage: storage
});