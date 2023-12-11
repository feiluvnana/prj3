import express = require('express');
import crypto = require('crypto');
import Joi = require('joi');
import { Student } from '../models/student.model';
import StudentService from '../services/student.service';
import AuthUtils from '../utils/util';

export const register = async (req: express.Request, res: express.Response) => {
    let isRegistered = await StudentService.isRegistered(req.body.email, req.body.password).catch(err => {
        res.status(err.status).json({
            message: err.message
        })
    });
    if (res.headersSent) return;
    if (isRegistered) {
        res.status(400).json({
            message: "Email is already registered."
        });
        return;
    }
    await StudentService.register(req.body.email, req.body.password).catch(err => {
        res.status(err.status).json({
            message: err.message
        })
    });
    if (res.headersSent) return;
    res.status(201).json({
        message: "Student registered successfully."
    });
}

export const login = async (req: express.Request, res: express.Response) => {
    let token = await StudentService.login(req.body.email, req.body.password).catch(err => {
        res.status(err.status).json({
            message: err.message
        });
    });
    if (res.headersSent) return
    res.status(200).json({
        message: "Đăng nhập thành công.",
        data: token
    });
}

// export const verify = async (req: express.Request, res: express.Response) => {
//     if (req.params.key == null || !regex.activation_key.test(req.params.key)) {
//         views.res422_wrongparam(res);
//         return;
//     }

//     let student: any = await Student.find({
//         "key.value": req.params.key,
//         "key.expiredAt": { $gte: Date.now() }
//     })
//         .then(students => (students.length == 0) ? views.res404_nokey(res) : students[0])
//         .catch(err => views.res500(res));

//     if (res.headersSent) return;

//     student.active = true;
//     await student.save()
//         .then(value => views.res200_accountactivated(res))
//         .catch(err => views.res500(res));
// }