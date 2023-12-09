// import express = require('express');
// import regex = require('../configs/regex');
// import crypto = require('crypto');
// import Joi = require('joi');
// import { Student } from '../models/student.model';
// import { Course } from '../models/course.model';

// export const create = async (req: express.Request, res: express.Response) => {
//     if (req.headers.authorization == null) {
//         views.res403(res);
//         return;
//     }

//     let auth = req.headers.authorization.split(" ");
//     if (auth[0].toLowerCase() !== "bearer") {
//         views.res403(res);
//         return;
//     }

//     let student: any = await Student.find({
//         "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }
//     })
//         .then(students => (students.length == 0) ? views.res403(res) : students[0])
//         .catch(err => views.res500(res));

//     if (res.headersSent) return;

//     var schema = Joi.object({
//         id: Joi.string().required(),
//         mid: Joi.number(),
//         final: Joi.number(),
//         name: Joi.string().required(),
//         midFactor: Joi.number().required(),
//         courseFactor: Joi.number().required(),
//         schedule: Joi.object({
//             start: Joi.number().required(),
//             end: Joi.number().required(),
//             weekday: Joi.number().required(),
//             week: Joi.array<number>().required()
//         }).required(),
//         semester: Joi.object({
//             "start": Joi.number().required(),
//             "name": Joi.string().required(),
//         })
//     })
//     // if (schema.validate({...req.body, "schedule": req.body["schedule"]}).error !== undefined) {
//     //     views.res422_wrongparam(res, schema.validate({...req.body, "schedule": JSON.parse(req.body["schedule"] || "{}")}).error.message);
//     //     return;
//     // }

//     let event = new Course({
//         ...{...req.body},
//         student: student._id
//     });
//     await event.save()
//         .then(document => res.status(201).json({
//             "code": "201 - Created",
//             "message": "Khóa học được tạo thành công"
//         }))
//         .catch(err => { console.log(err); views.res500(res) });
// }

// export const read = async (req: express.Request, res: express.Response) => {
//     if (req.headers.authorization == null) {
//         views.res403(res);
//         return;
//     }

//     let auth = req.headers.authorization.split(" ");
//     if (auth[0].toLowerCase() !== "bearer") {
//         views.res403(res);
//         return;
//     }

//     let student: any = await Student.find({
//         "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }
//     })
//         .then(students => (students.length == 0) ? views.res403(res) : students[0])
//         .catch(err => views.res500(res));

//     if (res.headersSent) return;

//     await Course.find({
//         student: student._id
//     })
//         .then(courses => res.status(201).json({
//             "code": "200 - OK",
//             "data": courses
//         }))
//         .catch(err => { console.log(err); views.res500(res) });
// }