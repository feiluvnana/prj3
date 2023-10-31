import mongoose from "mongoose";

const aschema = new mongoose.Schema({
    email: {
        type: String,
        require: true
    },
    avatar: String,
});

const schema = new mongoose.Schema({
    email: {
        type: String,
        require: true
    },
    password: {
        type: String,
        require: true
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
    courses: {
        type: [
            typeof new mongoose.Schema({
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
                }
            })
        ],
        default: []
    },
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

export const AuthorSchema = aschema;