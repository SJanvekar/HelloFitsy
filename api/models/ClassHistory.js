var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassHistorySchema = new Schema({

    //UserID
    UserID: {
        type: String,
        required: true,
        unique: true,
        index: true
    },

    //Class ID
    ClassID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Class',
        required: true,
        unique: true,
        index: true
    },

    //Date class was taken
    DateTaken: {
        type: Date,
        required: false,
    },

    //TakenStartTimes
    TakenStartTimes: [{
        type: Date,
        required: false,
    }],

    //Did trainee miss class
    IsMissed: {
        type: Boolean
    },

    //Did trainee cancell class
    IsCancelled: {
        type: Boolean
    }
})

module.exports = mongoose.model('Class History', ClassHistorySchema)