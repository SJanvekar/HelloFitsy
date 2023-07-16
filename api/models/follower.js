var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserFollowerSchema = new Schema({

    //Follower Username
    FollowerUsername: {
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

    //Follower account Profile Image URL
    FollowerProfileImageURL: {
        type: String,
        required: false

    },
    
    //Follower account First Name
    FollowerFirstName: {
        type: String,
        required: true
    },

    //Follower account Last Name
    FollowerLastName: {
        type: String,
        required: true
    },

    //Follower account User Bio
    FollowerUserBio: {
        type: String,
        required: false
    },
})

module.exports = mongoose.model('Follower', UserFollowerSchema)