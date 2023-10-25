var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassPurchasedSchema = new Schema({

    //Class ID
    ClassID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Class',
        required: true,
    },

    //Purchased User ID
    UserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },

    //Class Schedules
    ClassTimes: [{
        //Start Date
        StartDate: {
            type: Date,
        },

        //End Date
        EndDate: {
            type: Date,
        },


        //Recurrence Type
        // Recurrence: {
        //     type: [{

        //     type: String,
        //         enum: ['None', 'Daily', 'Weekly', 'BiWeekly', 'Monthly', 'Yearly']
        //         }],

        //     default: ['None'],
        // },
    }],

    //Class Schedules that the user decides to update
    UpdatedClassTimes: [{
        //Start Date
        StartDate: {
            type: Date,
        },

        //End Date
        EndDate: {
            type: Date,
        },

        ScheduleReference: {
            type: mongoose.Schema.Types.ObjectId,
            required: true,
        }
    }],

    //Class Schedules that the user decides to cancel
    CancelledClassTimes: [{
        //Start Date
        StartDate: {
            type: Date,
        },

        //End Date
        EndDate: {
            type: Date,
        },

        ScheduleReference: {
            type: mongoose.Schema.Types.ObjectId,
            required: true,
        }
    }],

    //Date Booked
    DateBooked: {
        type: Date,
        required: true,
    },

    //Price Paid
    PricePaid: {
        type: Number,
        required: true,
    },

    //Did trainee miss class
    IsMissed: {
        type: Boolean
    },

    //Did trainee cancell class
    IsCancelled: {
        type: Boolean
    },

    //Trainee's cancellation reason
    CancellationReason: {
        type: String
    }
})

module.exports = mongoose.model('Class Purchased', ClassPurchasedSchema)