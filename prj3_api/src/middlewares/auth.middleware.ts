import express = require('express');
import StudentService from '../services/student.service';

export const auth = async (req: express.Request, res: express.Response, next: express.NextFunction) => {
    if (req.headers.authorization === undefined) {
        res.status(403).json({
            message: "Invalid token."
        });
        return;
    }
    let authorization = req.headers.authorization.split(" ");
    if (authorization[0].toLowerCase() !== "bearer") {
        res.status(403).json({
            message: "Invalid token."
        });
        return;
    }
    if(res.headersSent) return;
    let isValid = await StudentService.verifyToken(authorization[1]).catch(err => {
        res.status(err.status).json({
            message: err.message
        });
    })
    if(res.headersSent) return;
    if(!isValid) {
        res.status(403).json({
            message: "Invalid token."
        });
        return;
    }
    return next();
}