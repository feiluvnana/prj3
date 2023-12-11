import express = require('express');
import StudentService from '../services/student.service';
import { Course } from '../models/course.model';
import CourseService from '../services/course.service';

export const create = async (req: express.Request, res: express.Response) => {
    let student: any = await StudentService.getStudent(req.headers.authorization.split(" ")[1]).catch(err => res.status(500).json({
        message: err.message
    }));
    if (res.headersSent) return;
    let course = new Course({
        ...req.body,
        student: student._id
    });
    await course.save().catch(err => res.status(500).json({
        message: err.message
    }));
    if (res.headersSent) return;
    res.status(201).json({
        message: "Đã tạo học phần thành công."
    });
}

export const read = async (req: express.Request, res: express.Response) => {
    let student: any = await StudentService.getStudent(req.headers.authorization.split(" ")[1]).catch(err => res.status(500).json({
        message: err.message
    }));
    if (res.headersSent) return;
    let courses = await CourseService.get(student._id).catch(err => res.status(500).json({
        message: err.message
    }));
    if (res.headersSent) return;
    res.status(200).json({
        message: "Lấy học phần thành công.",
        meta: {
            type: "collection",
            count: (courses as any[]).length
        },
        courses: courses
    });
}