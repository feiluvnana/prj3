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

    static async get(params: {
        offset: number,
        limit: number,
        sort: number,
        tags: mongoose.Types.ObjectId[],
        name: string,
        originalName: string
    }) {
        let matchObj = {
            tags: params.tags.length != 0 ? { $in: params.tags } : undefined,
            createdAt: params.offset != -1 ? { $lt: params.offset } : undefined,
            name: params.name !== "" ? { $regex: RegExp(params.name, "i") } : undefined,
            originalName: params.originalName !== "" ? { $regex: RegExp(params.originalName, "i") } : undefined
        };
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
            .then(documents => documents)
            .catch(err => {
                throw new InternalError(500, "Internal Error.");
            });
    }

    static async getTags() {
        return Tag.find({}, { "__v": 0 })
            .then(tags => tags)
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
            .then(document => document)
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