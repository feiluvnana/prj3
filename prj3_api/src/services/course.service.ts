import mongoose from "mongoose";
import InternalError from "../values/error";
import { Course } from "../models/course.model";

export default class CourseService {
    static async create(params: {
        id: string,
        mid: number | undefined,
        final: number | undefined,
        name: string,
        midFactor: number,
        courseFactor: number,
        schedule: {
            start: number,
            end: number,
            weekday: number,
            week: [number]
        },
        semester: {
            start: number,
            name: number,
        },
        student: mongoose.Types.ObjectId
    }) {
        let course = new Course(params);
        await course.save()
            .catch(err => {
                console.log(err);
                throw new InternalError(500, "Internal Error.")
            });
    }

    static async get(studentId: mongoose.Types.ObjectId) {
        return await Course.find({
            student: studentId
        })
        .catch(err => {
            console.log(err);
            throw new InternalError(500, "Internal Error.")
        });
    }
}