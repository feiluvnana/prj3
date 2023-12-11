import express = require('express');

export const notfound = async (req: express.Request, res: express.Response, next: express.NextFunction) => {
    res.status(404).json({
        "message": "Lạc đường rồi. Tìm đường về nhà đi nhé."
    });
}