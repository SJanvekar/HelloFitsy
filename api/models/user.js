var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');
const crypto = require("crypto");

var validateEmail = function() {
    var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    return re.test(UserEmail)
};

const id = crypto.randomBytes(16).toString("hex");

var UserSchema = new Schema({
    //userID
    UserID: {
        type: String,
        default: id,
        unique: true

    },

    //isActive User
    isActive: {
        type: Boolean,
        default: true,
    },

    //isTrainer or isTrainee
    UserType: {
        type: [{

        type: String,
            enum: ['Trainer', 'Trainee']
            }],

        default: ['Trainee'],
        required: true,

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
        lowercase: true

    },
    //Unique User Email
    UserEmail: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        required: 'Email address is required',
        // validate: [validateEmail, 'Please fill a valid email address'],
    },

    //Password
    Password: {
        type: String,
        required: true

    },

})

UserSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('Password') || this.isNew){
        bcrypt.genSalt(10, function (err, salt){
            if (err) {
                return next(err)
            }
            bcrypt.hash(user.Password, salt, function (err, hash){
                if (err){
                    return next(err)
                }
                user.Password = hash;
                next()
            })
        })
    }
    else{
        return next()
    }

})

UserSchema.methods.comparePassword = function(passw, cb){
    bcrypt.compare(passw, this.Password, function(err, isMatch){
        if(err){
            return cb(err)
        }
        cb(null, isMatch)
    })
}

module.exports = mongoose.model('User', UserSchema)