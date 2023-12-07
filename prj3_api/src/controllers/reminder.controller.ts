import express = require('express');
import regex = require('../helpers/regex');
import views = require('../views/view');
import crypto = require('crypto');
import { Student } from '../models/student.model';
import Joi = require('joi');
import { Reminder } from '../models/reminder.model';

export const create = async (req: express.Request, res: express.Response) => {
    if (req.headers.authorization == null) {
        views.res403(res);
        return;
    }

    let auth = req.headers.authorization.split(" ");
    if (auth[0].toLowerCase() !== "bearer") {
        views.res403(res);
        return;
    }

    let student: any = await Student.find({
        "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }
    })
        .then(students => (students.length == 0) ? views.res403(res) : students[0])
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    switch (req.body["type"]) {
        case "Event":
            var schema = Joi.object({
                name: Joi.string().required(),
                description: Joi.string().required(),
                timestamp: Joi.number().required(),
                preNotifyTime: Joi.number().required(),
                type: Joi.string().required().pattern(/^Event$/),
            })
            if (schema.validate(req.body).error !== undefined) {
                views.res422_wrongparam(res, schema.validate(req.body).error.message);
                return;
            }
            let event = new Reminder({
                ...req.body,
                student: student._id
            });
            await event.save()
                .then(document => res.status(201).json({
                    "code": "201 - Created",
                    "message": "Sự kiện được tạo thành công"
                }))
                .catch(err => { console.log(err); views.res500(res) });
            return;
        case "Remind":
            var schema = Joi.object({
                name: Joi.string().required(),
                description: Joi.string().required(),
                schedule: Joi.required(),
                type: Joi.string().required().pattern(/^Remind$/)
            })
            if (schema.validate(req.body).error !== undefined) {
                views.res422_wrongparam(res, schema.validate(req.body).error.message);
                return;
            }
            await Student.updateOne(
                {
                    "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }
                },
                {
                    $push: {
                        "reminders": {
                            name: req.body["name"],
                            type: "Remind",
                            description: req.body["description"],
                            schedule: req.body["schedule"],
                            createdAt: Date.now()
                        }
                    }
                })
                .then(value => res.status(201).json({
                    code: "201 - Created",
                    message: "Nhắc hẹn được tạo thành công."
                }))
                .catch(err => views.res500(res));
            return;
        case "Target":
            var schema = Joi.object({
                name: Joi.string().required(),
                description: Joi.string().required(),
                timestamp: Joi.number().required(),
                isCompleted: Joi.boolean().required(),
                type: Joi.string().required().pattern(/^Event$/)
            })
            if (schema.validate(req.body).error !== undefined) {
                views.res422_wrongparam(res, schema.validate(req.body).error.message);
                return;
            }
            await Student.updateOne(
                {
                    "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }
                },
                {
                    $push: {
                        "reminders": {
                            name: req.body["name"],
                            type: "Target",
                            description: req.body["description"],
                            timestamp: req.body["timestamp"],
                            createdAt: Date.now()
                        }
                    }
                })
                .then(value => res.status(201).json({
                    code: "201 - Created",
                    message: "Mục tiêu được tạo thành công."
                }))
                .catch(err => views.res500(res));
            return;
        default:
            views.res422_wrongparam(res);
    }
}

export const get = async (req: express.Request, res: express.Response) => {
    if (req.headers.authorization == null) {
        views.res403(res);
        return;
    }

    if (typeof req.query["type"] !== "string") {
        views.res422_wrongparam(res);
        return;
    }

    let auth = req.headers.authorization.split(" ");
    if (auth[0].toLowerCase() !== "bearer") {
        views.res403(res);
        return;
    }

    let student: any = await Student.find({
        "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }
    })
        .then(students => (students.length == 0) ? views.res403(res) : students[0])
        .catch(err => views.res500(res));
    
    if(res.headersSent) return;

    await Reminder.aggregate([
        {
            '$match': {
                "student": student._id,
                "type": req.query["type"]
            }
        },
        {
            '$sort': {
                "createdAt": -1
            }
        },
        { '$limit': 10 },
        {
            '$project': {
                __v: 0,
            }
        },
        {
            '$lookup': {
                'from': 'students',
                'localField': 'student',
                'foreignField': '_id',
                'as': 'student',
                'pipeline': [
                    {
                        '$project': {
                            'email': 1,
                            'avatar': 1
                        }
                    }
                ]
            }
        },
        {
            '$unwind': {
                'path': '$student'
            }
        },
    ]).then(reminders => res.status(200).json({
        code: "200 - OK",
        data: {
            reminders: reminders
        }
    })).catch(err => views.res500);
}