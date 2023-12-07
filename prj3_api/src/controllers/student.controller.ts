import express = require('express');
import regex = require('../helpers/regex');
import views = require('../views/view');
import crypto = require('crypto');
import Joi = require('joi');
import { Student } from '../models/student.model';

export const register = async (req: express.Request, res: express.Response) => {
    const schema = Joi.object({
        email: Joi.string().required().pattern(regex.email),
        password: Joi.string().required()
    })
    
    if(schema.validate(req.body).error !== undefined) {
        views.res422_wrongparam(res, schema.validate(req.body).error.message);
        return;
    }

    await Student.find({
        email: req.body["email"]
    })
        .then(students => (students.length != 0) ? views.res200_duplicateemail(res) : null)
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    let student = new Student({
        email: req.body["email"],
        password: req.body["password"],
        key: {
            value: crypto.createHash('md5').update(req.body["email"] + crypto.randomInt(1000000).toString().padStart(6, "0")).digest("hex"),
            expiredAt: Date.now() + 600000
        }
    });
    await student.save()
        .then(value => {
            // mailerconfig.sendVerifyCode(value.email, `http://localhost:3802/account/verify/${value.key.value}`);
            views.res201_accountcreated(res);
        })
        .catch(err => views.res500(res));
}

export const verify = async (req: express.Request, res: express.Response) => {
    if (req.params.key == null || !regex.activation_key.test(req.params.key)) {
        views.res422_wrongparam(res);
        return;
    }

    let student: any = await Student.find({
        "key.value": req.params.key,
        "key.expiredAt": { $gte: Date.now() }
    })
        .then(students => (students.length == 0) ? views.res404_nokey(res) : students[0])
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    student.active = true;
    await student.save()
        .then(value => views.res200_accountactivated(res))
        .catch(err => views.res500(res));
}

export const login = async (req: express.Request, res: express.Response) => {
    const schema = Joi.object({
        email: Joi.string().required().pattern(regex.email),
        password: Joi.string().required()
    })
    
    if(schema.validate(req.body).error !== undefined) {
        views.res422_wrongparam(res, schema.validate(req.body).error.message);
        return;
    }


    let student: any = await Student.find({
        "email": req.body.email,
        "password": req.body.password
    })
        .then(students => (students.length == 0) ? views.res401_wronguserpass(res) : (students[0].active) ? students[0] : views.res401_notactive(res))
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    if(student.token != null) {
        if(student.token["expiredAt"] > Date.now()) {
            res.status(200).json({
                code: "200 - OK",
                message: "Đăng nhập thành công.",
                data: student.token
            });
        }
    }

    if (res.headersSent) return;

    let now = Date.now();
    student.token = {
        value: crypto.createHash('sha1').update(student.email + now.toString()).digest("hex"),
        expiredAt: now + 1000 * 3600 * 24
    };
    await student.save()
        .then(value => res.status(200).json({
            code: "200 - OK",
            message: "Đăng nhập thành công.",
            data: {
                value: crypto.createHash('sha1').update(student.email + now.toString()).digest("hex"),
                expiredAt: now + 1000 * 3600 * 24
            }
        }))
        .catch(err => views.res500(res));
}

export const get = async (req: express.Request, res: express.Response) => {
    if (req.headers.authorization == null) {
        views.res403(res);
        return;
    }

    let auth = req.headers.authorization.split(" ");
    if (auth[0].toLowerCase() !== "bearer") {
        views.res403(res);
        return;
    }

    let student: any = await Student.aggregate([{
        "$match": {
                "token.value": auth[1], "token.expiredAt": {$gt: Date.now()}
        }
    },
    {
        "$project": {
            "password": 0,
            "__v": 0,
            "active": 0,
            "key": 0,
            "token": 0
        }
    }])
        .then(students => (students.length == 0) ? views.res403(res) : students[0])
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    res.status(200).json({
        code: "200 - OK",
        data: student
    })
}

export const put = async (req: express.Request, res: express.Response) => {
    if (req.headers.authorization == null) {
        views.res403(res);
        return;
    }

    let auth = req.headers.authorization.split(" ");
    if (auth[0].toLowerCase() !== "bearer") {
        views.res403(res);
        return;
    }

    let student : any = await Student.find({
        "token.value": auth[1], "token.expiredAt": {$gt: Date.now()}  
    })
        .then(students => (students.length == 0) ? views.res403(res) : students[0])
        .catch(err => views.res500(res));

    student.week = req.body["week"];
    await student.save().then((value) => res.status(200).json({"code": "200 - OK"}));
    if (res.headersSent) return;
}