import mongoose from "mongoose";
import { Reminder } from "../models/reminder.model";
import InternalError from "../values/error";

export default class ReminderService {
    static async create(params: {
        name: string,
        classification: String,
        description: string,
        schedule: {
            timestamp: number,
            weekday: [number]
        },
        student: mongoose.Types.ObjectId,
        timestamp: number,
        preNotifyTime: number,
        isCompleted: boolean
    }) {
        let reminder = new Reminder(params);
        await reminder.save()
            .catch(err => {
                console.log(err);
                throw new InternalError(500, "Internal Error.")
            });
    }

    static async get(studentId: mongoose.Types.ObjectId, classification: string) {
        return await Reminder.aggregate([
            {
                '$match': {
                    "student": studentId,
                    "classification": classification
                }
            },
            {
                '$sort': {
                    "createdAt": -1
                }
            },
            { '$limit': 10 },
            {
                '$project': {
                    __v: 0,
                }
            },
            {
                '$lookup': {
                    'from': 'students',
                    'localField': 'student',
                    'foreignField': '_id',
                    'as': 'student',
                    'pipeline': [
                        {
                            '$project': {
                                'email': 1,
                            }
                        }
                    ]
                }
            },
            {
                '$unwind': {
                    'path': '$student'
                }
            },
        ])
        .catch(err => {
            console.log(err);
            throw new InternalError(500, "Internal Error.")
        })
    }
}