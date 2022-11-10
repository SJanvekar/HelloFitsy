var User = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')

var functions = {
    //Add New User fnc
    addNew: function (req, res){
        if  ((!req.body.UserType) || (!req.body.FirstName) || (!req.body.LastName) || (!req.body.Username) || (!req.body.UserEmail) || (!req.body.Password)){
            res.json({success: false, msg: 'Enter all fields'})
        }
        else{
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
            newUser.save(function (err, newUser){
                if(err){
                    // print('failure');
                    res.json(err)
                }
                else {
                    // print('I have posted');
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    },

    // Authenticate User fnc
    authenticate: function(req, res){
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

    // Get Information
    getinfo: function (req, res){
        if(req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer'){
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, config.secret)
            return res.json({success: true, msg: 'Hello ' + decodedtoken.FirstName })
        }else {
            return res.json({success: false, msg: 'No Headers'})
        }
    }
}

module.exports = functions