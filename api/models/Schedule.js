var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ScheduleSchema = new Schema({
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
})

module.exports = mongoose.model('Schedule', ScheduleSchema)