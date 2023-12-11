import mongoose from "mongoose";

const schema = new mongoose.Schema({
    courseId: String,
    name: String,
    midFactor: Number,
    mid: Number,
    final: Number,
    courseFactor: Number,
    student: { type: mongoose.Schema.Types.ObjectId, ref: 'Student' },
    schedule: {
        start: Number,
        end: Number,
        weekday: Number,
        week: [Number]
    },
    semester: {
        start: Number,
        name: String
    },
    createdAt: Number,
    updatedAt: Number
}, {
    timestamps: {
        currentTime: () => Date.now()
    }
});

const model = mongoose.model(
    "Course",
    schema
);

export const Course = model;