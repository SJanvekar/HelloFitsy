var mongoose = require('mongoose');
var Schedule = require('./Schedule');
var Schema = mongoose.Schema;

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
        required: false
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

    //Class Trainer Reference
    ClassTrainerID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true,
    },

    // //Class Schedules
    // ClassTimes: {
    //     type: [Schedule.schema],
    //     required: false,
    // },

    //Class Schedules
    ClassTimes: [
        {
            //Start Date
            StartDate: {
                type: Date,
                required: true
            },

            //End Date
            EndDate: {
                type: Date,
                required: true
            },

            //Recurrence Type
            Recurrence: {
                type: [{

                type: String,
                    enum: ['None', 'Daily', 'Weekly', 'BiWeekly', 'Monthly', 'Yearly']
                    }],

                default: ['None'],
                required: true,
            },
            required: false,
        },
    ],

    //Categories (Linked)
    Categories: [{
        type: String,
        required: false,
    }],
})

module.exports = mongoose.model('Class', ClassSchema)