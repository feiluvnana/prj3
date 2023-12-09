import express = require('express');

import { studentRoute } from './routes/student.route';
import { init as dbinit } from './configs/db';
import { documentRoute } from './routes/document.route';
import { cors } from './middlewares/cors.middleware';
import { notfound } from './middlewares/notfound.middleware';

const port = 3802;
async function main() {
    await dbinit();  
    const app = express();
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
    app.use(cors);
    app.use("/api/v1/file/view", express.static("F:\\Desktop\\my-crash-course\\prj3\\prj3_api\\upload"));
    app.use("/api/v1/student", studentRoute);
    app.use("/api/v1/document", documentRoute);
    // app.use("/reminder", reminderRoute);
    // app.use("/course", courseRoute);
    app.use(notfound);
    app.listen(port, "localhost", () => {
        console.log(`Listening on port ${port}`);
    });
}

main();
