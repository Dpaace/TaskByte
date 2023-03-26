const mongoose = require('mongoose');


const postSchema = mongoose.Schema({
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true
    },
    postTime : {
        type: String,
        required: true
    },
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    image: {
        type: String,
        // required: true
    },
    likes: [{
          type: mongoose.Schema.Types.ObjectId,
          ref: 'User',
    }],
    comment: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Comments"
    }]
});
// }, { timestamps: true });

module.exports = mongoose.model('Post', postSchema);
