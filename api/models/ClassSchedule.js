var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');
const crypto = require("crypto");

const id = crypto.randomBytes(16).toString("hex");

var ClassScheduleSchema = new Schema({
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

    //Class ID
    Class: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Class',
        required: true,
        unique: true,
    },

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
    
    //Class Type
    ClassType: {
        type: [{

        type: String,
            enum: ['Solo', 'Group', 'Virtual']
            }],

        default: ['Solo'],
        required: true,
    },

    //Class Trainer
    ClassTrainer: {
        type: String,
        required: true,
    },

    PurchasedUser: {
        type: String,
        required: false,
    }
})

module.exports = mongoose.model('ClassSchedule', ClassScheduleSchema)