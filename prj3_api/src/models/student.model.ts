import mongoose from "mongoose";

const schema = new mongoose.Schema({
    email: {
        type: String,
        required: true
    },
    password: {
        type: String,
        required: true,
        selected: false
    },
    avatar: String,
    token: typeof new mongoose.Schema({
        value: String,
        expiredAt: Date
    }),
    key: typeof new mongoose.Schema({
        value: String,
        expiredAt: Date
    }),
    active: {
        type: Boolean,
        default: false
    },
    week: Number,
    createdAt: Number,
    updatedAt: Number
}, {
    timestamps: {
        currentTime: () => Date.now()
    }
});

const model = mongoose.model(
    "Student",
    schema
);

export const Student = model;

export const StudentSchema = schema;