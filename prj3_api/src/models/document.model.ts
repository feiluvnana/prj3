import mongoose from "mongoose";

const model = mongoose.model(
    "Document",
    new mongoose.Schema({
        name: { type: String, required: true },
        originalName: { type: String, required: true },
        size: Number,
        vote: {
            type: typeof new mongoose.Schema({
                detail: [{
                    author: { type: mongoose.Schema.Types.ObjectId, ref: 'Student' },
                    vote: Number
                }],
                count: Number
            }),
            default: {detail:[], count:0}
        },
        author: { type: mongoose.Schema.Types.ObjectId, ref: 'Student' },
        tags: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Tag' }],
        createdAt: Number,
        updatedAt: Number
    }, {
        timestamps: {
            currentTime: () => Date.now()
        }
    })
);

export const Document = model;

const model2 = mongoose.model(
    "Tag",
    new mongoose.Schema({
        name: { type: String, required: true },
        description: { type: String, required: true }
    })
)

export const Tag = model2;