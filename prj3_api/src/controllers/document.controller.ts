import express = require('express');
import mongoose from 'mongoose';
import DocumentService from '../services/document.service';
import StudentService from '../services/student.service';

export const upload = async (req: express.Request, res: express.Response) => {
    let student = await StudentService.getStudent(req.headers.authorization.split(" ")[1]).catch(err => res.status(500).json({
        message: err.message
    }));
    await DocumentService.create({
        name: req.file.path.split("\\")[req.file.path.split("\\").length - 1],
        originalName: req.file.originalname,
        tags: (JSON.parse(req.body.tags) as string[]).map(value => new mongoose.Types.ObjectId(value)),
        size: req.file.size,
        author: student._id
    })
        .catch(err => res.status(err.status).json({
            message: err.message
        }))
    if (res.headersSent) return;
    res.status(200).json({
        message: "File được tải lên thành công"
    });
}

export const get = async (req: express.Request, res: express.Response) => {
    const offset = req.query["offset"] as unknown as number;
    const limit = req.query["limit"] as unknown as number;
    const name = req.query["name"] as string;
    const originalName = req.query["originalName"] as string;
    const sort = req.query["sort"] as unknown as number;
    const tags = (req.query["tags"] as string[]).map(value => new mongoose.Types.ObjectId(value));
    let documents = await DocumentService.get({ offset, limit, name, originalName, sort, tags }).catch(err => res.status(err.status).json({
        message: err.message
    }));
    if (res.headersSent) return;
    res.status(200).json({
        message: "Lấy tài liệu thành công.",
        meta: {
            type: "collection",
            count: (documents as any[]).length
        },
        data: documents
    })
}

export const getTags = async (req: express.Request, res: express.Response) => {
    let tags = await DocumentService.getTags().catch(err => res.status(err.status).json({
        message: err.message
    }));
    if (res.headersSent) return;
    res.status(200).json({
        message: "Lấy thể loại thành công.",
        meta: {
            type: "collection",
            count: (tags as any[]).length
        },
        data: tags
    })
}

export const vote = async (req: express.Request, res: express.Response) => {
    let student = await StudentService.getStudent(req.headers.authorization.split(" ")[1]).catch(err => res.status(500).json({
        message: err.message
    }));
    if (req.body["vote"] === 0) {
        await DocumentService.cancelVote(new mongoose.Types.ObjectId(req.body["id"]), req.body["oldVote"], student._id).catch(err => res.status(err.status).json({
            message: err.message
        }));
        return;
    }
    let document = await DocumentService.findReversedVote(new mongoose.Types.ObjectId(req.body["id"]), req.body["vote"], student._id).catch(err => res.status(err.status).json({
        message: err.message
    }));
    if (res.headersSent) return;
    DocumentService.vote(new mongoose.Types.ObjectId(req.body["id"]), req.body["vote"], student._id, document != null).catch(err => res.status(err.status).json({
        message: err.message
    }));
    if (res.headersSent) return;
    res.status(200).json({
        message: "Bình chọn thành công."
    });
}