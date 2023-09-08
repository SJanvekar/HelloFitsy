var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserFollowerSchema = new Schema({

    //User perspective of their followers Username
    FollowerUsername: {
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

module.exports = mongoose.model('Follower', UserFollowerSchema)