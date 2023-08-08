var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');
const crypto = require("crypto");

const id = crypto.randomBytes(16).toString("hex");

var ClassSchema = new Schema({
    //Class Name
    ClassName: {
        type: String,
        required: true
    },

    //Class Name
    ClassImageUrl: {
        type: String,
        required: true
    },
    
    //Class Desc
    ClassDescription: {
        type: String,
        required: true
    },

    //Class What to expect
    ClassWhatToExpect: {
        type: String,
        required: true
    },

    //Class User Requirements
    ClassUserRequirements: {
        type: String,
        required: true
    },

    //Class Type
    ClassType: {
        type: [{

        type: String,
            enum: ['Solo', 'Group', 'Virtual']
            }],

        default: ['Solo'],
        required: true,
    },

    //Class Location Name
    ClassLocationName: {
        type: String,
        required: true
    },

    //Class Latitude
    ClassLatitude: {
        type: Number,
        required: true
    },

    //Class Longitude
    ClassLongitude: {
        type: Number,
        required: true
    },

    //Class Overall Rating
    ClassOverallRating: {
        type: Number,
        required: true
    },

    //Class Reviews Amount
    ClassReviewsAmount: {
        type: Number,
        required: true
    },

    //Class Price
    ClassPrice: {
        type: Number,
        required: true,
    },

    //Class Trainer
    ClassTrainer: {
        type: String,
        required: true,
    },

    //Categories (Linked)
    Categories: [{
        type: String,
        required: false,
    }],

    //Trainer Profile Image URL
    TrainerImageUrl: {
        type: String,
        required: false
    },
    
    //Trainer First Name
    TrainerFirstName: {
        type: String,
        required: true
    },

    //Last Name
    TrainerLastName: {
        type: String,
        required: true
    },
})

module.exports = mongoose.model('Class', ClassSchema)