var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassHistorySchema = new Schema({

    //Username
    Username: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        index: true
    },

    //Class ID
    ClassID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Class',
        required: true,
        unique: true,
    },

    //User Full name
    DateTaken: {
        type: String,
        required: true,
    },

    StartTime: {
        type: Date,
    },

    //User Full name
    Price: {
        type: Number,
        required: true,
    },

    //User Full name
    CompletedStatus: {
        type: String,
        required: true,
    },
})

module.exports = mongoose.model('Class History', ClassHistorySchema)