var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserFollowerSchema = new Schema({

    //User perspective of their followers User ID
    FollowerUserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true
    },

    //User ID
    UserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true
    },
})

module.exports = mongoose.model('Follower', UserFollowerSchema)