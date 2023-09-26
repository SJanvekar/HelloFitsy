var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserSchema = new Schema({

    //isActive User
    IsActive: {
        type: Boolean,
        default: true,
        required: true,
    },

    //isTrainer or isTrainee
    UserType: {
        type: [{

        type: String,
            enum: ['Trainee', 'Trainer']
            }],

        default: 'Trainee',
        required: true,
    },

    //Profile Image URL
    ProfileImageURL: {
        type: String,
        required: false

    },
    
    //First Name
    FirstName: {
        type: String,
        required: true
    },

    //Last Name
    LastName: {
        type: String,
        required: true
    },
    
    //Username
    Username: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        index: true
    },

    //User Bio
    UserBio: {
        type: String,
        required: false
    },

    //Auth Reference
    Auth: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Auth',
        required: true,
        unique: true,
    },

    //Categories (Liked)
    Categories: [{
        type: String,
        required: false,
    }],

    //Stripe Account ID
    StripeAccountID: {
        type: String,
        required: false
    },

    //Stripe Customer ID
    StripeCustomerID: {
        type: String,
        required: false
    },
    
    
})

module.exports = mongoose.model('User', UserSchema)