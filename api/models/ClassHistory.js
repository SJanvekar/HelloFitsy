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
    }
})

module.exports = mongoose.model('Class History', ClassHistorySchema)