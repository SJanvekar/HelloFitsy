var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')
const { findOne } = require('../models/user')

var functions = {
    
//*****GET REQUESTS*****//

    // Get Information
    getinfo: function (req, res) {
        const userPromiseAsync = (responseJSON) => {
            return new Promise((resolve, reject) => {
                let responseString = JSON.stringify(responseJSON)
                var user = User()
                user = JSON.parse(responseString)
                //TODO: Confirm this is actually checking for null
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
            User.findOne({UserID: decodedtoken.UserID, $or:
                [{ Username: req.query.Account}, {UserEmail: req.query.Account}]}, function (err, user) {
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
                console.log(response)
                return res.json({success: true, searchResults: response})
            }
        })
    },

//*****POST REQUESTS*****//

    // Get User Following list
    updateUserinfo: function (req, res) {
        User.findOneAndUpdate({'Username': req.body.OldUsername}, {$set: {'FirstName' : req.body.FirstName, 
        'LastName' : req.body.LastName, 'Username' : req.body.NewUsername, 'UserBio' : req.body.UserBio, 'ProfileImageURL': req.body.ProfileImageURL}}, 
            function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, errorCode: err.code,})
              
            } else {
                return res.json({success: true})
            }
        })
    },

    //Add New User fnc
    addNew: async function (req, res){
        if  ((!req.body.UserType) || (!req.body.FirstName) || (!req.body.LastName) || (!req.body.Username) || (!req.body.UserEmail) || (!req.body.Password)){
            res.json({success: false, msg: 'Enter all fields'})
            
        }
        else {
            console.log(req.body.UserType)
            var newUser = User({
                UserID: req.body.UserID,
                IsActive: req.body.IsActive,
                UserType: req.body.UserType,
                ProfileImageURL: req.body.ProfileImageURL,
                FirstName: req.body.FirstName,
                LastName: req.body.LastName,
                Username: req.body.Username,
                UserEmail: req.body.UserEmail,
                Password: req.body.Password,
                Categories: req.body.Categories,
                LikedClasses: req.body.LikedClasses,
                ClassHistory: req.body.ClassHistory,
                Following: req.body.Following,
                Followers: req.body.Followers,
            });
            await newUser.save(function (err, newUser){
                if(err){
                    console.error(err)
                    res.send({success: false, msg: "Didnt work bithc"})
                }
                else {
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    },

    // Authenticate User fnc
    authenticate: function(req, res) {
        User.findOne({ $or:
           [{ Username: req.body.Username}, {UserEmail: req.body.UserEmail}]},
         function(err, user){
            if (err) throw err
            if (!user){
                res.status(403).send({success: false, msg: 'Incorrect username. Please try again.'})
            }

            else {
                user.comparePassword(req.body.Password, function (err, isMatch){
                    if(isMatch && !err){
                        var token = jwt.encode(user, config.secret)
                        res.json({success: true, token: token})
                        
                    }else{
                        return res.status(403).send({success: false, msg: 'The password you have entered is incorrect. Please try again.'})
                    }
                })
            }
        })
    },
}

module.exports = functions