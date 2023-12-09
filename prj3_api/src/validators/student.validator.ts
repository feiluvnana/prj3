import express = require('express');
import Joi = require('joi');

export const validateAuthInfo = (req: express.Request, res: express.Response, next: express.NextFunction) => {
    const schema = Joi.object({
        email: Joi.string().required().pattern(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/),
        password: Joi.string().required()
    });
    if(schema.validate(req.body).error !== undefined) {
        res.status(422).json({
            "message": schema.validate(req.body).error.message
        })
        return;
    }
    return next();
}
