const mongoose = require("mongoose")

const groupSchema = mongoose.Schema({
    groupName: {
        type: String,
        required: true
    },    
});
// }, { timestamps: true });

module.exports = mongoose.model("Group", groupSchema)


