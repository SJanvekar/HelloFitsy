var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassReviewSchema = new Schema({

    //Class Name
    ClassName: {
        type: String,
        required: true
    },

    //Trainer Username
    TrainerUsername: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        index: true
    },

    //Trainee Username
    TraineeUsername: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        index: true
    },

    //Review Rating
    Rating: {
        type: Number,
        required: true
    },

    //Date Submitted
    DateSubmitted: {
        type: Date,
        required: true
    },

    //Review Title
    ReviewTitle: {
        type: String,
        required: true
    },

    //Review Body
    ReviewBody: {
        type: String,
        required: true
    },

    //TODO: Add Class ObjectID ref when working on implementation
})

module.exports = mongoose.model('Class Reviews', ClassReviewSchema)