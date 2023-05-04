var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserFollowingSchema = new Schema({

    //Following Username
    FollowingUsername: {
        type: String,
        required: true,
        unique: true,
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

    //Following account Profile Image URL
    FollowingProfileImageURL: {
        type: String,
        required: false

    },
    
    //Following account First Name
    FollowingFirstName: {
        type: String,
        required: true
    },

    //Following account Last Name
    FollowingLastName: {
        type: String,
        required: true
    },

    //Following account User Bio
    FollowingUserBio: {
        type: String,
        required: false
    },
})

module.exports = mongoose.model('Following', UserFollowingSchema)