import express = require('express');
import regex = require('../helpers/regex');
import views = require('../views/view');
import crypto = require('crypto');
import { Student } from '../models/student.model';
import { Document, Tag } from '../models/document.model';
import mongoose from 'mongoose';
import Joi = require('joi');
import multer = require('multer');

export const upload = async (req: express.Request, res: express.Response) => {
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

    const schema = Joi.object({
        file: Joi.required(),
        tags: Joi.array<string>().required()
    });

    if (schema.validate({ "file": req.file, "tags": JSON.parse(req.body) }).error !== undefined) {
        views.res422_wrongparam(res, schema.validate({ "file": req.file, "tags": JSON.parse(req.body) }).error.message);
        return;
    }

    let document = new Document({
        name: req.file.path.split("\\")[req.file.path.split("\\").length - 1],
        originalName: req.file.originalname,
        tags: JSON.parse(req.body),
        size: req.file.size,
        author: student._id
    });

    await document.save()
        .then(document => views.res200_fileuploaded(res))
        .catch(err => { console.log(err); views.res500(res) });
}

export const getDocuments = async (req: express.Request, res: express.Response) => {
    if (req.headers.authorization == null) {
        views.res403(res);
        return;
    }

    let auth = req.headers.authorization.split(" ");
    if (auth[0].toLowerCase() !== "bearer") {
        views.res403(res);
        return;
    }

    await Student.find({  
            "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }   
    })
        .then(students => (students.length == 0) ? views.res403(res) : students[0])
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    const offset: number = req.query["offset"] == null ? -1 : parseInt(req.query["offset"].toString()) || -1;
    const limit: number = req.query["limit"] == null ? 10 : parseInt(req.query["limit"].toString()) || -1;
    const name: string = req.query["name"] == null ? "" : req.query["name"].toString();
    const originalName: string = req.query["originalName"] == null ? "" : req.query["originalName"].toString();
    let tags: string[];
    try {
        tags = req.query["tags"] == null ? [] : JSON.parse(req.query["tags"].toString()) || [];
    } catch {
        tags = [];
    }
    const sort: number = req.query["sort"] == null ? 0 : parseInt(req.query["sort"].toString()) || 0;

    if (limit == -1) {
        views.res422_wrongparam(res);
        return;
    }

    let matchObj = {};
    if (offset != -1) {
        matchObj = {
            ...matchObj,
            createdAt: { $lt: offset }
        }
    }
    if (tags.length != 0) {
        matchObj = {
            ...matchObj,
            tags: {
                $in: tags.map(e => new mongoose.Types.ObjectId(e))
            }
        }
    }
    if (name !== "") {
        matchObj = {
            ...matchObj,
            name: {
                $regex: RegExp(name, "i")
            }
        }
    }
    if (originalName !== "") {
        matchObj = {
            ...matchObj,
            originalName: {
                $regex: RegExp(originalName, "i")
            }
        }
    }

    let sortObj = {};
    if (sort == 1) {
        sortObj = {
            'vote.count': -1
        }
    } else {
        sortObj = {
            'createdAt': -1
        }
    }

    await Document.aggregate([
        { '$match': matchObj },
        { '$sort': sortObj },
        { '$limit': limit },
        {
            '$lookup': {
                'from': 'students',
                'localField': 'author',
                'foreignField': '_id',
                'as': 'author',
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
            '$lookup': {
                'from': 'tags',
                'localField': 'tags',
                'foreignField': '_id',
                'as': 'tags',
                'pipeline': [
                    {
                        '$project': {
                            "__v": 0,
                            "description": 0
                        }
                    }
                ]
            }
        },
        {
            '$unwind': {
                'path': '$author'
            }
        },
        {
            '$project': {
                "__v": 0
            }
        }
    ])
        .then(documents => res.status(200).json({
            "code": "200 - OK",
            "data": {
                "documents": documents
            },
            "meta": {
                "count": documents.length,
                "offset": documents.length == 0 ? -1 : (documents)[documents.length - 1]["createdAt"]
            }
        }))
        .catch(err => views.res500(res));
}

export const getTags = async (req: express.Request, res: express.Response) => {
    if (req.headers.authorization == null) {
        views.res403(res);
        return;
    }

    let auth = req.headers.authorization.split(" ");
    if (auth[0].toLowerCase() !== "bearer") {
        views.res403(res);
        return;
    }

    await Student.find({
            "token.value": auth[1], "token.expiredAt": { $gt: Date.now() }
    })
        .then(students => (students.length == 0) ? views.res403(res) : students[0])
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    await Tag.aggregate([
        {
            '$match': {}
        },
        {
            '$project': { "__v": 0 }
        }
    ])
        .then(tags => res.status(200).json({
            "code": "200 - OK",
            "data": {
                "tags": tags
            },
            "meta": {
                "count": tags.length,
            }
        }))
        .catch(err => views.res500(res));
}

export const vote = async (req: express.Request, res: express.Response) => {
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

    if ((req.body["vote"] !== 1 && req.body["vote"] !== -1 && req.body["vote"] !== 0) || !((typeof req.body["id"]) === "string")) {
        views.res422_wrongparam(res);
        return;
    }

    if (req.body["vote"] === 0) {
        await Document.updateOne(
            {
                "_id": new mongoose.Types.ObjectId(req.body["id"].toString()),
                "vote.detail": {
                    $in: [{
                        "author": student._id,
                        "vote": 1
                    }, {
                        "author": student._id,
                        "vote": -1
                    }]
                }
            }, {
            "$pull": {
                "vote.detail": { "author": student._id }
            },
            "$inc": {
                "vote.count": - req.body["oldVote"]
            }
        }
        ).then(value => res.status(200).json({
            code: "200 - OK",
            message: "Hủy bình chọn thành công."
        }))
            .catch(err => console.log(err))


        return;
    }

    await Document.find({
        "_id": new mongoose.Types.ObjectId(req.body["id"].toString()),
        "vote.detail": {
            $in: [{
                "author": new mongoose.Types.ObjectId(student._id.toString()),
                "vote": req.body["vote"]
            }]
        }
    })
        .then(documents => (documents.length == 0) ? null : res.status(409).json({
            code: "409 - Conflict",
            message: "Bạn đã bình chọn rồi."
        }))
        .catch(err => views.res500(res));

    if (res.headersSent) return;

    let document: any = await Document.find({
        "_id": new mongoose.Types.ObjectId(req.body["id"].toString()),
        "vote.detail": {
            $in: [{
                "author": new mongoose.Types.ObjectId(student._id.toString()),
                "vote": - req.body["vote"]
            }]
        }
    })
        .then(documents => (documents.length == 0) ? null : documents[0])
        .catch(err => {
            console.log(err);
            views.res500(res)
        });

    if (res.headersSent) return;


    await Document.updateOne({
        "_id": new mongoose.Types.ObjectId(req.body["id"].toString())
    }, {
        $inc: {
            "vote.count": req.body["vote"]
        },
        $push: {
            "vote.detail": {
                "author": student._id,
                "vote": req.body["vote"]
            }
        }
    }).then(async _ => {
        if (document != null) {
            await Document.updateOne({
                "_id": new mongoose.Types.ObjectId(req.body["id"].toString())
            }, {
                $inc: {
                    "vote.count": req.body["vote"]
                },
                $pull: {
                    "vote.detail": {
                        "author": student._id,
                        "vote": - req.body["vote"]
                    }
                }
            })
                .then(value => res.status(200).json({
                    code: "200 - OK",
                    message: "Bình chọn thành công."
                }))
                .catch(err => console.log(err));
        } else {
            res.status(200).json({
                code: "200 - OK",
                message: "Bình chọn thành công."
            })
        }
    })
        .catch(err => console.log(err));
}