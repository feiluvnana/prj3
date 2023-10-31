import mongoose from "mongoose";
import { AuthorSchema } from "./student.model";

const model = mongoose.model(
    "Document",
    new mongoose.Schema({
        name: {type: String, require: true},
        originalName: {type: String, require: true},
        size: Number,
        author: typeof AuthorSchema,
        tags: [String],
        createdAt: Number,
        updatedAt: Number
    }, {
        timestamps: {
            currentTime: () => Date.now()
        }
    })
);

export const Document = model;