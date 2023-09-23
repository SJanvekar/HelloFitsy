var User = require('../models/User')
var Auth = require('../models/Auth')
var jwt = require('jwt-simple')
// var config = require('../../config/Private/dbconfig')
const dotenv = require('dotenv');
dotenv.config();
const { json } = require('body-parser')
const { findOne } = require('../models/User')
const { default: mongoose } = require('mongoose')
const { use } = require('passport')

var functions = {
  
    //Add New User fnc
    addNew: async function (req, res) {
        if  ((!req.body.UserType) || (!req.body.FirstName) || (!req.body.LastName) || (!req.body.Username) || (!req.body.UserEmail) || (!req.body.Password)){
            return res.json({success: false, msg: 'Enter all fields'})
        }
        var newAuth = Auth({
            UserEmail: req.body.UserEmail,
            UserPhone: req.body.UserPhone,
            Password: req.body.Password,
        })
        try {
            savedAuth = await newAuth.save()
        } catch (err) {
            return res.send({success: false, msg: "Didn't save auth, " + err})
        }
        var newUser = User({
            IsActive: req.body.IsActive,
            UserType: req.body.UserType,
            ProfileImageURL: req.body.ProfileImageURL,
            FirstName: req.body.FirstName,
            LastName: req.body.LastName,
            Username: req.body.Username,
            Auth: newAuth.id,
            Categories: req.body.Categories,
            LikedClasses: req.body.LikedClasses,
            ClassHistory: req.body.ClassHistory,
            Following: req.body.Following,
            Followers: req.body.Followers,
            StripeAccountID: req.body.StripeAccountID
        });
        try {
            await newUser.save()
        } catch (err) {
            try {
                Auth.deleteOne({UserEmail: savedAuth.UserEmail})
            } catch (err) {
                return res.send({success: false, msg: "Couldn't delete auth, something went horribly wrong, " + err})
            }
            return res.send({success: false, msg: "Didn't save user, " + err})
        }
        return res.send({success: true, msg: 'Successfully saved'})
    },

    // Authenticate User fnc
    authenticate: async function(req, res) {
        var newAuth = null;
        var newUser = null;
        try {
            newAuth = await Auth.findOne({UserEmail: req.body.Username}); //Find user by email
            newUser = await User.findOne({Username: req.body.Username}); //Find user by username
        } catch (err) { //Something is horribly wrong
            return res.json({success: false, msg: 'Something went wrong' + err})
        }

        if (newAuth == null) {
            if (newUser == null) {
                console.log("Error authenticating")
                return res.status(403).send({success: false, msg: 'Incorrect username or email. Please try again.'})
            } else {
                try {
                    newAuth = await Auth.findById(newUser.Auth)
                } catch (err) {
                    return res.json({success: false, msg: 'Something went wrong' + err})
                }
            }
        }
        newAuth.comparePassword(req.body.Password, function (err, isMatch) {
            if (isMatch && !err) {
                var token = jwt.encode(newAuth, config.secret)
                return res.json({success: true, token: token})
            } else {
                console.log("Error Incorrect Password")
                return res.status(403).send({success: false, msg: 'The password you have entered is incorrect. Please try again.'})
            }
        })
    },

//*****GET REQUESTS*****//

    // Get Information after log in
    getLogInInfo: async function (req, res) {
        const userPromiseAsync = (responseJSON) => {
            return new Promise((resolve, reject) => {
                let responseString = JSON.stringify(responseJSON)
                var user = User()
                user = JSON.parse(responseString)
                if (user) {
                    resolve(user)
                } else {
                    reject(new Error('userPromiseAsync returned null'))
                }
            })
        }
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, config.secret)
            try {
                user = await User.findOne({Auth: decodedtoken._id})
            } catch (err) {
                console.log(err)
                return res.json({success: false, msg: err})
            }
            return userPromiseAsync(user).then(function (parsedResponse) {
                if (parsedResponse instanceof Error) {
                    return res.json({success: false, msg: "Failed to convert response to JSON:" + parsedResponse})
                } else {
                    return res.json({success: true, 
                        _id: parsedResponse._id,
                        userType: String(parsedResponse.UserType), 
                        profileImageURL: parsedResponse.ProfileImageURL,
                        userName: parsedResponse.Username,
                        firstName: parsedResponse.FirstName,
                        lastName: parsedResponse.LastName,
                        categories: parsedResponse.Categories,
                        stripeAccountID: parsedResponse.StripeAccountID,})
                }
            })
        } else {
            return res.json({success: false, msg: 'No Headers'})
        }
    },

    //Get trainer information for class
    getClassTrainerInfo: async function (req, res) {
        const classTrainerInfoAsync = (responseJSON) => {
            return new Promise((resolve, reject) => {
                let responseString = JSON.stringify(responseJSON)
                var user = User()
                user = JSON.parse(responseString)
                if (user) {
                    resolve(user)
                } else {
                    reject(new Error('classTrainerInfoAsync returned null'))
                }
            })
        }
        if ((!req.query.UserID)) {
            res.json({success: false, msg: 'Missing query parameter UserID'});
        }
        try {
            user = await User.findOne({_id: new mongoose.Types.ObjectId(req.query.UserID)}, '_id ProfileImageURL FirstName LastName Username')
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return classTrainerInfoAsync(user).then(parsedResponse => 
            res.json({success: true,
                _id: parsedResponse._id, 
                ProfileImageURL: parsedResponse.ProfileImageURL,
                Username: parsedResponse.Username,
                FirstName: parsedResponse.FirstName,
                LastName: parsedResponse.LastName}))
    },

    // Search Trainers
    searchTrainers: async function (req, res) {
        try {
            response = await User.aggregate([
                {$search: {
                    index: 'Username',
                    text: {
                        query: req.query.SearchIndex,
                        path: 'Username',
                        fuzzy: {}
                    }
                }},
                {$match: {UserType: 'Trainer'}},
            ])
        } catch (err) {
            console.log(err)
            return res.json({success: false, errorCode: err.code})
        }
        return res.json({success: true, searchResults: response})
    },

//*****POST REQUESTS*****//
  
    updateUserinfo: async function (req, res) {
        try {
            await User.findOneAndUpdate({'_id':  new mongoose.Types.ObjectId(req.body.UserID)}, 
            {$set: {'FirstName' : req.body.FirstName, 
                    'LastName' : req.body.LastName, 
                    'Username' : req.body.NewUsername, 
                    'UserBio' : req.body.UserBio, 
                    'ProfileImageURL': req.body.ProfileImageURL}})
        } catch (err) {
            console.log(err)
            return res.json({success: false, errorCode: err.code})
        }
    },

    //Update user stripe account ID on accountID creation (Stripe set up)
    updateUserStripeAccountID: async function (req, res) {
        // Find the user by Username
        try {
            user = await User.findOne({'Username': req.body.Username})
        } catch (err) {
            console.log(err);
            return res.json({ success: false, errorCode: err.code });
        }
        user.StripeAccountID = req.body.StripeAccountID;
        // Save the updated user
        try {
            await user.save()
        } catch (err) {
            console.error(err);
            return res.json({ success: false, errorCode: err.code });
        }
        return res.json({ success: true });
      },
}

module.exports = functions