import express = require('express');
import regex = require('../helpers/regex');
import views = require('../views/view_template');
import crypto = require('crypto');
import { Student } from '../models/student.model';

export const register = async (req: express.Request, res: express.Response) => {
    if (req.body["email"] == null || req.body["password"] == null || !regex.email.test(req.body["email"]) || !regex.password.test(req.body["password"])) {
        views.res422_wrongparam(res);
        return;
    }

    await Student.find({
        email: req.body["email"]
    })
    .then(students => (students.length != 0) ? views.res200_duplicateemail(res) : null)
    .catch(err => views.res500(res));

    if(res.headersSent) return;

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

    let student : any = await Student.find({
        "key.value": req.params.key,
        "key.expiredAt": {$gte: Date.now()}
    })
    .then(students => (students.length == 0) ? views.res404_nokey(res) : students[0])
    .catch(err => views.res500(res));

    if(res.headersSent) return;

    student.active = true;
    await student.save()
    .then(value => views.res200_accountactivated(res))
    .catch(err => views.res500(res));
}

export const login = async (req: express.Request, res: express.Response) => {
    if (req.body.email === null || req.body.password === null || !regex.email.test(req.body.email) || !regex.password.test(req.body.password)) {
        views.res422_wrongparam(res);
        return;
    }


    let student : any = await Student.find({
        "email": req.body.email,
        "password": req.body.password
    })
    .then(students => (students.length == 0) ? views.res401_wronguserpass(res) : (students[0].active) ? students[0] : views.res401_notactive(res))
    .catch(err => views.res500(res));

    if(res.headersSent) return;

    if(student.token != null) {
        res.status(200).json({
            code: "200 - OK",
            message: "Đăng nhập thành công.",
            data: student.token 
        });
        return;
    }

    let now = Date.now();
    student.token = {
        value: crypto.createHash('sha1').update(student.email + now.toString()).digest("hex"),
        expiredAt: now + 1000 * 3600 * 24
    }
    await student.save()
    .then(value => res.status(200).json({
        code: "200 - OK",
        message: "Đăng nhập thành công.",
        data: value.token  
    }))
    .catch(err => views.res500(res));
}
