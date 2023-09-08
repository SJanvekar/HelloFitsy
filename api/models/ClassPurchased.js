var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassPurchasedSchema = new Schema({
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
    ClassID: {
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

module.exports = mongoose.model('ClassPurchased', ClassPurchasedSchema)