import express = require('express');
import regex = require('../helpers/regex');
import views = require('../views/view_template');
import crypto = require('crypto');
import { Student } from '../models/student.model';
import { Document } from '../models/document.model';

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

    if (!req.hasOwnProperty("file")) {
        views.res422_wrongfile(res);
        return;
    }

    if (req.body["tags"] == null || typeof req.body["tags"] != "string" || !Array.isArray(JSON.parse(req.body["tags"]))) {
        views.res422_wrongparam(res);
        return;
    }

    let student : any = await Student.find({
        "token.value": auth[1]
    })
    .then(students => (students.length == 0) ? views.res403(res) : students[0])
    .catch(err => views.res500(res));

    if(res.headersSent) return;

    let document = new Document({
        name: req.file.path.split("\\")[req.file.path.split("\\").length - 1],
        originalName: req.file.originalname,
        tags: JSON.parse(req.body["tags"]),
        size: req.file.size,
        author: {
            email: student.email,
            avatar: student.avatar
        }
    });

    await document.save()
    .then(document => views.res200_fileuploaded(res))
    .catch(err => views.res500(res));
}

// export const get = async (req: express.Request, res: express.Response) => {
//     if (req.headers.authorization == null) {
//         views.res403(res);
//         return;
//     }

//     let auth = req.headers.authorization.split(" ");
//     if (auth[0].toLowerCase() !== "bearer") {
//         views.res403(res);
//         return;
//     }

//     const offset: number | undefined = req.query["offset"] == null ? -1 : parseInt(req.query["offset"].toString()) || -1;
//     const limit: number | undefined = req.query["limit"] == null ? 10 : parseInt(req.query["limit"].toString()) || -1;

//     let result = await File.read(offset, limit);
//     if (!(result[0] instanceof File)) {
//         views.res500(res);
//         return;
//     }

//     res.status(200).json({
//         "code": "200 - OK",
//         "data": {
//             "files": result.map((e: File) => {
//                 return {
//                     "name": e.filename,
//                     "createdAt": parseInt(e.filename.substring(e.filename.lastIndexOf(".") - 13, e.filename.lastIndexOf("."))),
//                     "size": e.size,
//                     "author": e.email,
//                     "tags": e.tag.map(t => { return { "id": t.id, "name": t.name }; })
//                 }
//             })
//         },
//         "meta": {
//             "count": (result as File[]).length,
//             "offset": (result as File[])[(result as File[]).length - 1].id
//         }
//     })
// }

// export const getGenre = async (req: express.Request, res: express.Response) => {
//     if (req.headers.authorization == null) {
//         views.res403(res);
//         return;
//     }

//     let auth = req.headers.authorization.split(" ");
//     if (auth[0].toLowerCase() !== "bearer") {
//         views.res403(res);
//         return;
//     }

//     let result = await Genre.read();

//     res.status(200).json({
//         "code": "200 - OK",
//         "data": {
//             "genres": result.map((e: Genre) => {
//                 return {
//                     "id": e.id,
//                     "name": e.name
//                 }
//             })
//         },
//         "meta": {
//             "count": (result as File[]).length,
//         }
//     })
// }