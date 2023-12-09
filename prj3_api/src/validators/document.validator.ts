import express = require('express');
import Joi = require('joi');

export const validateUploadDocumentInfo = (req: express.Request, res: express.Response, next: express.NextFunction) => {
    const schema = Joi.object({
        document: Joi.required(),
        tags: Joi.array<string>().required()
    });
    let tags = req.body.tags === undefined ? undefined : JSON.parse(req.body.tags);
    if (schema.validate({"document": req.file, "tags": tags}).error !== undefined) {
        res.status(422).json({
            "message": schema.validate({"document": req.file, "tags": tags}).error.message
        });
        return;
    }
    return next();
}

export const validateGetDocumentInfo = (req: express.Request, res: express.Response, next: express.NextFunction) => {
    const schema = Joi.object({
        offset: Joi.number().default(-1),
        limit: Joi.number().default(10),
        name: Joi.string().default(""),
        originalName: Joi.string().default(""),
        tags: Joi.array<string>().default([]),
        sort: Joi.number().default(0)
    });
    let tags = req.query.tags === undefined ? undefined : JSON.parse(req.query.tags.toString());
    if (schema.validate({...req.query, "tags": tags}).error !== undefined) {
        res.status(422).json({
            "message": schema.validate({...req.query, "tags": tags}).error.message
        });
        return;
    }
    req.query = schema.validate({...req.query, "tags": tags}).value;
    return next();
}

export const validateVoteDocumentInfo = (req: express.Request, res: express.Response, next: express.NextFunction) => {
    const schema = Joi.object({
        id: Joi.string().required(),
        vote: Joi.number().integer().min(-1).max(1).required(),
        oldVote: Joi.number().integer().min(-1).max(1).required()
    });
    if (schema.validate(req.body).error!== undefined) {
        res.status(422).json({
            "message": schema.validate(req.body).error.message
        });
        return;
    }
    return next();
}