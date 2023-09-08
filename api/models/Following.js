var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserFollowingSchema = new Schema({

    //User perspective of who they're following Username
    FollowingUsername: {
        type: String,
        required: true,
        lowercase: true,
        index: true
    },

    //Username
    Username: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        index: true
    },
})

module.exports = mongoose.model('Following', UserFollowingSchema)