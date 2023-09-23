var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');

var validateEmail = function() {
    var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    return re.test(UserEmail)
};

var AuthSchema = new Schema({
    //Unique User Email
    UserEmail: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
        index: true,
        required: 'Email address is required',
        // validate: [validateEmail, 'Please fill a valid email address'],
    },

    //Unique User Phone
    UserPhone: {
        type: String,
        required: true,
        required: 'Phone number is required',
    },

    //Password
    Password: {
        type: String,
        required: true
    },
})

AuthSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('Password') || this.isNew) {
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

AuthSchema.methods.comparePassword = function(passw, cb){
    bcrypt.compare(passw, this.Password, function(err, isMatch){
        if (err) {
            return cb(err)
        }
        cb(null, isMatch)
    })
}

module.exports = mongoose.model('Auth', AuthSchema)