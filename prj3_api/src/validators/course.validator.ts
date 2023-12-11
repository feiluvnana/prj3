import express = require('express');
import Joi = require('joi');

export const validateCreateCourseInfo = (req: express.Request, res: express.Response, next: express.NextFunction) => {
    var schema = Joi.object({
        id: Joi.string().required(),
        mid: Joi.number(),
        final: Joi.number(),
        name: Joi.string().required(),
        midFactor: Joi.number().required(),
        courseFactor: Joi.number().required(),
        schedule: Joi.object({
            start: Joi.number().required(),
            end: Joi.number().required(),
            weekday: Joi.number().required(),
            week: Joi.array<number>().required()
        }).required(),
        semester: Joi.object({
            "start": Joi.number().required(),
            "name": Joi.string().required(),
        })
    })
    if (schema.validate(req.body).error !== undefined) {
        res.status(422).json({
            message: schema.validate(req.body).error.message
        });
        return;
    }
    return next();
}