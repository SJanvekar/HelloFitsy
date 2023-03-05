var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');
const crypto = require("crypto");

const id = crypto.randomBytes(16).toString("hex");

var ClassSchema = new Schema({
    //classID
    ClassID: {
        type: String,
        default: id,
        unique: true

    },

    //Class Name
    ClassName: {
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

    //Class Location
    ClassLocation: {
        type: String,
        required: true

    },

    //Class Rating
    ClassRating: {
        type: Number,
        required: true

    },

    //Class Review
    ClassReview: {
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
        required: true,
    },

    ClassLiked: {
        type: Boolean,
        required: true,
        default: false
    },

})

module.exports = mongoose.model('Class', ClassSchema)