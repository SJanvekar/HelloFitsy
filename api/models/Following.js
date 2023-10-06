var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserFollowingSchema = new Schema({

    //User perspective of who they're following User ID
    FollowingUserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },

    //User ID
    UserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
})

module.exports = mongoose.model('Following', UserFollowingSchema)