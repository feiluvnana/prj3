import mongoose from 'mongoose';
import { Document, Tag } from '../models/document.model';
import InternalError from '../values/error';

export default class DocumentService {
    static async create(params: {
        name: string,
        originalName: string,
        tags: mongoose.Types.ObjectId[],
        author: string,
        size: number,
    }) {
        let document = new Document(params);
        await document.save()
            .catch(err => {
                console.log(err);
                throw new InternalError(500, "Internal Error.")
            });
    }

    static async getTotalUploadDocumentCount(studentId: mongoose.Types.ObjectId): Promise<number> {
        return Document.aggregate([
            {
                '$match': {
                    author: studentId
                }
            }
        ]).then(documents => documents.length)
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }

    static async getTotalUploadDocumentCountByGenre(studentId: mongoose.Types.ObjectId) {
        return Document.aggregate([
            {
                '$match': {
                    author: studentId
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
                '$unwind': '$tags'
            },
            {
                '$group': {
                    _id: '$tags.name',
                    count: {
                        '$sum': 1
                    }
                }
            }
        ])
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }

    static async getTotalUploadDocumentCountLastMonth(studentId: mongoose.Types.ObjectId): Promise<number> {
        return Document.aggregate([
            {
                '$match': {
                    author: studentId,
                    createdAt: { "$gt": Date.now() - 1000 * 60 * 60 * 24 * 30 }
                },
            },
        ])
            .then(documents => documents.length)
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }

    static async get(params: {
        offset: number,
        limit: number,
        sort: number,
        tags: mongoose.Types.ObjectId[],
        name: string,
        originalName: string
    }) {
        let matchObj = {};
        if (params.tags.length !== 0) matchObj["tags"] = { $in: params.tags };
        if (params.offset !== -1) matchObj["createdAt"] = { $lt: params.offset };
        if (params.name !== "") matchObj["name"] = { $regex: RegExp(params.name, "i") };
        if (params.originalName !== "") matchObj["originalName"] = { $regex: RegExp(params.originalName, "i") };
        let sortObj = {};
        if (params.sort == 1) {
            sortObj = {
                'vote.count': -1
            }
        } else {
            sortObj = {
                'createdAt': -1
            }
        }
        return Document.aggregate([
            { '$match': matchObj },
            { '$sort': sortObj },
            { '$limit': params.limit },
            {
                '$lookup': {
                    'from': 'students',
                    'localField': 'author',
                    'foreignField': '_id',
                    'as': 'author',
                    'pipeline': [
                        {
                            '$project': {
                                'email': 1
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
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }

    static async getTags() {
        return Tag.find({}, { "__v": 0 })
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }

    static async cancelVote(id: mongoose.Types.ObjectId, oldVote: number, studentId: mongoose.Types.ObjectId) {
        Document.updateOne(
            { "_id": id },
            {
                "$pull": {
                    "vote.detail": { "author": studentId }
                },
                "$inc": {
                    "vote.count": - oldVote
                }
            }
        ).catch(err => {
            throw new InternalError(500, "Internal Error.");
        });
    }

    static async findReversedVote(id: mongoose.Types.ObjectId, vote: number, studentId: mongoose.Types.ObjectId) {
        return Document.findOne({
            "_id": id,
            "vote.detail": {
                $in: [{
                    "author": studentId,
                    "vote": - vote
                }]
            }
        })
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }

    static async vote(id: mongoose.Types.ObjectId, vote: number, studentId: mongoose.Types.ObjectId, isReversed: boolean) {
        await Document.updateOne({
            "_id": id
        }, {
            $inc: {
                "vote.count": vote
            },
            $push: {
                "vote.detail": {
                    "author": studentId,
                    "vote": vote
                }
            }
        }).then(async _ => {
            if (isReversed) {
                await Document.updateOne({
                    "_id": id
                }, {
                    $inc: {
                        "vote.count": vote
                    },
                    $pull: {
                        "vote.detail": {
                            "author": studentId,
                            "vote": - vote
                        }
                    }
                }).catch(err => {
                    throw new InternalError(500, "Internal Error.");
                });
            }
        })
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }
}