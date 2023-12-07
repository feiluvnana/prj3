import mongoose from "mongoose";

const schema = new mongoose.Schema({
    name: {
        type: String,
        require: true
    },
    type: {
        type: String,
        require: true
    },
    description: {
        type: String,
        require: true
    },
    schedule: typeof new mongoose.Schema({
        timestamp: Number,
        weekday: [Number]
    }),
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

export const ReminderSchema = schema;