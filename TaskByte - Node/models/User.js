const mongoose = require("mongoose")

const userSchema = mongoose.Schema({
    firstName: {
        type: String,
        // required: true
    }, 
    lastName: {
        type: String,
        // required: true
    },
    dateOfBirth: {
        // type: Date,
        type: String,
        // required: true
    },
    phoneNumber: {
        type: String,
        // required: true
    },
    interests: {
        type: String,
    },
    image: {
        type: String,   
        // required: true
    }, 
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true,
        minlenth: 6
    },
    posts: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Post",
        required: true
    }],
    
});
// }, { timestamps: true });

module.exports = mongoose.model("User", userSchema)


