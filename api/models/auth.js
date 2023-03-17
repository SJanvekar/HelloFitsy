var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');
const crypto = require("crypto");

const id = crypto.randomBytes(16).toString("hex");

var AuthSchema = new Schema({
    //authID
    AuthID: {
        type: String,
        default: id,
        unique: true,
        required: false,
    },

    //isActive User
    IsActive: {
        type: Boolean,
        default: true,
        required: true,
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

    }
})

AuthSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('Password') || this.isNew){
        bcrypt.genSalt(10, function (err, salt){
            if (err) {
                return next(err)
            }
            bcrypt.hash(user.Password, salt, function (err, hash){
                if (err) {
                    return next(err)
                }
                user.Password = hash;
                next()
            })
        })
    }
    else {
        return next()
    }

})

AuthSchema.methods.comparePassword = function(passw, cb) {
    bcrypt.compare(passw, this.Password, function(err, isMatch){
        if(err){
            return cb(err)
        }
        cb(null, isMatch)
    })
}

module.exports = mongoose.model('Auth', AuthSchema)