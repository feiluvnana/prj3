import express = require('express');
import { Student } from '../models/student.model';
import Joi = require('joi');
import { Reminder } from '../models/reminder.model';
import StudentService from '../services/student.service';
import ReminderService from '../services/reminder.service';

export const create = async (req: express.Request, res: express.Response) => {
    let student = await StudentService.getStudent(req.headers.authorization.split(" ")[1]).catch(err => res.status(err.status).json({
        message: err.message
    }));
    if (res.headersSent) return;
    await ReminderService.create({
        ...req.body,
        student: student._id
    }).catch(err => res.status(err.status).json({
        message: err.message
    }));
    if (res.headersSent) return;
    res.status(201).json({
        "message": "Đã tạo nhắc hẹn thành công."
    })
}

export const get = async (req: express.Request, res: express.Response) => {
    let student = await StudentService.getStudent(req.headers.authorization.split(" ")[1]).catch(err => res.status(err.status).json({
        message: err.message
    }));
    if(res.headersSent) return;
    await ReminderService.get(student._id, req.body["classification"])
    .then(reminders => res.status(200).json({
        message: "Lấy nhắc hẹn thành công.",
        meta: {
            type: "collection",
            count: (reminders as any[]).length
        },
        data: reminders
    })).catch(err => res.status(err.status).json({
        message: err.message
    }));
}