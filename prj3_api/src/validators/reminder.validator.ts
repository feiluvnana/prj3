import express = require('express');
import Joi = require('joi');

export const validateCreateReminderInfo = (req: express.Request, res: express.Response, next: express.NextFunction) => {
    switch (req.body["classification"]) {
        case "Event":
            var schema = Joi.object({
                name: Joi.string().required(),
                description: Joi.string().required(),
                timestamp: Joi.number().required(),
                preNotifyTime: Joi.number().required(),
                classification: Joi.string().required().pattern(/^Event$/),
            })
            if (schema.validate(req.body).error !== undefined) {
                res.status(422).json({
                    message: schema.validate(req.body).error.message
                })
            }
            break;
        case "Remind":
            var schema = Joi.object({
                name: Joi.string().required(),
                description: Joi.string().required(),
                schedule: Joi.required(),
                classification: Joi.string().required().pattern(/^Remind$/)
            })
            if (schema.validate(req.body).error !== undefined) {
                res.status(422).json({
                    message: schema.validate(req.body).error.message
                })
            }
            break;
        case "Target":
            var schema = Joi.object({
                name: Joi.string().required(),
                description: Joi.string().required(),
                timestamp: Joi.number().required(),
                isCompleted: Joi.boolean().required(),
                classification: Joi.string().required().pattern(/^Event$/)
            })
            if (schema.validate(req.body).error !== undefined) {
                res.status(422).json({
                    message: schema.validate(req.body).error.message
                })
            }
            break;
    }
    if(res.headersSent) return;
    return next();
}

export const validateGetReminderInfo = (req: express.Request, res: express.Response, next: express.NextFunction) => {

}