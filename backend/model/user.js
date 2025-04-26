const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema({
    username: {
        type: String,
        required:true
    },
    email: {
        type: String, 
        required: true,
        trim:true
    },
    password: {
        type: String, 
        required: true,
        trim:true
    },
    type: {
        type: String,
        default: "user"
    }
});

const userModel = mongoose.model("User", UserSchema);
module.exports = userModel;