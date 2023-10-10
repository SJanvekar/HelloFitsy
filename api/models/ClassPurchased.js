var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassPurchasedSchema = new Schema({

    //Class ID
    ClassID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Class',
        required: true,
    },

    //Purchased User ID
    UserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },

    //Class Purchased Schedule
    ClassTimes: {
        type: [Schedule.schema],
        required: true,
    },
})

module.exports = mongoose.model('Class Purchased', ClassPurchasedSchema)