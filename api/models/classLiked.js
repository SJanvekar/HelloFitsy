var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ClassLikedSchema = new Schema({

    //Username
    Username: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        index: true
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

    //Class Location
    ClassLocation: {
        type: String,
        required: true

    },

    //Class Trainer
    ClassTrainer: {
        type: String,
        required: true,
        required: true,
    },

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

module.exports = mongoose.model('Class Liked', ClassLikedSchema)