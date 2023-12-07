import mongoose from "mongoose";

const schema = new mongoose.Schema({
    id: {
        type: String,
        require: true
    },
    name: {
        type: String,
        require: true
    },
    midFactor: {
        type: Number,
        require: true
    },
    mid: Number,
    final: Number,
    courseFactor: {
        type: Number,
        require: true
    },
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

export const CourseSchema = schema;