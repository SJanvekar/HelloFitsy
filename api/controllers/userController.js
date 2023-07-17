var User = require('../models/user')
var Auth = require('../models/auth')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')
const { findOne } = require('../models/user')

var functions = {
  
    //Add New User fnc
    addNew: async function (req, res){
        if  ((!req.body.UserType) || (!req.body.FirstName) || (!req.body.LastName) || (!req.body.Username) || (!req.body.UserEmail) || (!req.body.Password)){
            return res.json({success: false, msg: 'Enter all fields'})
        }
        else {
            var newAuth = Auth({
                UserEmail: req.body.UserEmail,
                Password: req.body.Password,
            })
        
            await newAuth.save(function (err, newAuth) {
                if (err) {
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
                });
                newUser.save(function (err) {
                    if (err) { //TODO: Maybe delete auth object when error occurs
                        return res.send({success: false, msg: "Didn't save user, " + err})
                    }
                    return res.send({success: true, msg: 'Successfully saved'})
                })
            })
        }
    },

    // Authenticate User fnc
    authenticate: function(req, res) {

        Auth.findOne({UserEmail: req.body.Username}, function (err, newAuth) {
            if (err || newAuth == null) { //If not in Auth , check in User
                User.findOne({Username: req.body.Username}, function (err, newUser) {
                    if (err || newUser == null) { //Indicates incorrect username or email
                        console.log("Error authenticating: " + err)
                        return res.status(403).send({success: false, msg: 'Incorrect username or email. Please try again.'})
                    } else {
                        Auth.findById(newUser.Auth, function (err, newAuth) { //If in User, use objectID to find corresponding Auth object
                            if (err || newAuth == null) { //Something is horribly wrong
                                return res.json({success: false, msg: 'Something went wrong' + err})
                            } else {
                                newAuth.comparePassword(req.body.Password, function (err, isMatch) {
                                    if (isMatch && !err) {
                                        var token = jwt.encode(newAuth, config.secret)
                                        return res.json({success: true, token: token})
                                    } else {
                                        console.log("Error Incorrect Password")
                                        return res.status(403).send({success: false, msg: 'The password you have entered is incorrect. Please try again.'})
                                    }
                                })
                            }
                        })
                    }
                });
            } else {
                newAuth.comparePassword(req.body.Password, function (err, isMatch) {
                    if (isMatch && !err) {
                        var token = jwt.encode(newAuth, config.secret)
                        return res.json({success: true, token: token})
                    } else {
                        console.log("Error Incorrect Password")
                        return res.status(403).send({success: false, msg: 'The password you have entered is incorrect. Please try again.'})
                    }
                })
            }
        });
    },

//*****GET REQUESTS*****//

    // Get Information
    getinfo: function (req, res) {
        const userPromiseAsync = (responseJSON) => {
            return new Promise((resolve, reject) => {
                let responseString = JSON.stringify(responseJSON)
                var user = User()
                user = JSON.parse(responseString)
                if (user) {
                    resolve(user)
                } else {
                    reject(new Error('getInfo returned null'))
                }
            })
        }
        if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, config.secret)
            User.findOne({Auth: decodedtoken._id}, function (err, user) {
                if (err) {
                    console.log(err)
                    return res.json({success: false, body: err})
                } else {
                    return userPromiseAsync(user).then(parsedResponse => 
                        res.json({success: true, 
                            userType: String(parsedResponse.UserType), 
                            profileImageURL: parsedResponse.ProfileImageURL,
                            userName: parsedResponse.Username,
                            firstName: parsedResponse.FirstName,
                            lastName: parsedResponse.LastName,
                            userEmail: parsedResponse.UserEmail,
                            categories: parsedResponse.Categories,
                            likedClasses: parsedResponse.LikedClasses,
                            classHistory: parsedResponse.ClassHistory,
                            following: parsedResponse.Following,
                            followers: parsedResponse.Followers}))
                }
            })
        } else {
            return res.json({success: false, msg: 'No Headers'})
        }
    },

    // Get User Following list

    getUserFollowing: function (req, res) {
        if ((!req.query.Username)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        User.findOne({Username: req.query.Username}, 'Following', function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, body: err})
            } else {
                return res.json({success: true, 
                        following: response.Following
                    })
            }
        })
    },

    // Search Trainers
    searchTrainers: function (req, res) {
        User.aggregate([
            {$search: {
                index: 'Username',
                text: {
                    query: req.query.SearchIndex,
                    path: 'Username',
                    fuzzy: {}
                }
            }},
            {$match: {UserType: 'Trainer'}},
        ], function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, errorCode: err.code})
            } else {
                return res.json({success: true, searchResults: response})
            }
        })
    },

//*****POST REQUESTS*****//
  
    updateUserinfo: function (req, res) {
        User.findOneAndUpdate({'Username': req.body.OldUsername}, {$set: {'FirstName' : req.body.FirstName, 
        'LastName' : req.body.LastName, 'Username' : req.body.NewUsername, 'UserBio' : req.body.UserBio, 'ProfileImageURL': req.body.ProfileImageURL}}, 
            function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, errorCode: err.code})
              
            } else {
                return res.json({success: true})
            }
        })
    },
}

module.exports = functions