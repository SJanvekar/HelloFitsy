var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassLikedSchema = new Schema({

    //UserID
    UserID: {
        type:  mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true,
    },

    //Class ID
    ClassID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Class',
        required: true,
        unique: true,
    }
})

module.exports = mongoose.model('Class Liked', ClassLikedSchema)