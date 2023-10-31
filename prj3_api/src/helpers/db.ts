import mongoose from "mongoose";

// export const init = require("mongoose").connect("mongodb+srv://ntd271102:ColorfulworlD@cluster0.p1a3zbe.mongodb.net/?retryWrites=true&w=majority");
export const init = async () => await mongoose.connect("mongodb://127.0.0.1:27017/prj3");