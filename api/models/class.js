var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var bcrypt = require('bcrypt');
const crypto = require("crypto");

const id = crypto.randomBytes(16).toString("hex");

var ClassSchema = new Schema({
    //classID
    ClassID: {
        type: String,
        default: id,
        unique: true

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

    //Class Rating
    ClassRating: {
        type: Int,
        required: true

    },

    //Class Review
    ClassReview: {
        type: String,
        required: true

    },

    //Class Price
    ClassPrice: {
        type: Int,
        required: true,
    },

    //Class Trainer
    ClassTrainer: {
        type: String,
        required: true,
        required: true,
    },

    //Class Liked
    ClassLiked: {
        type: Boolean,
        required: true,
        default: false
    },

})

// UserSchema.pre('save', function (next) {
//     var user = this;
//     if (this.isModified('Password') || this.isNew){
//         bcrypt.genSalt(10, function (err, salt){
//             if (err) {
//                 return next(err)
//             }
//             bcrypt.hash(user.Password, salt, function (err, hash){
//                 if (err){
//                     return next(err)
//                 }
//                 user.Password = hash;
//                 next()
//             })
//         })
//     }
//     else{
//         return next()
//     }

// })

// UserSchema.methods.comparePassword = function(passw, cb){
//     bcrypt.compare(passw, this.Password, function(err, isMatch){
//         if(err){
//             return cb(err)
//         }
//         cb(null, isMatch)
//     })
// }

module.exports = mongoose.model('Class', ClassSchema)