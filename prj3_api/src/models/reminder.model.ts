import mongoose from "mongoose";

const schema = new mongoose.Schema({
    name: String,
    classification: String,
    description: String,
    schedule: {
        timestamp: Number,
        weekday: [Number]
    },
    student: { type: mongoose.Schema.Types.ObjectId, ref: 'Student' },
    timestamp: Number,
    preNotifyTime: Number,
    isCompleted: Boolean,
    createdAt: Number,
    updatedAt: Number
}, {
    timestamps: {
        currentTime: () => Date.now()
    }
});

const model = mongoose.model(
    "Reminder",
    schema
);

export const Reminder = model;