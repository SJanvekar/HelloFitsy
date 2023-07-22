var Following = require('../models/Following')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')

var functions = {
    //Add New Following
    addFollowing: function (req, res) {
        if ((!req.body.Username || !req.body.FollowingUserName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            var newFollowing = Following({
                FollowingUsername: req.body.FollowingUserName,
                Username: req.body.Username,
                FollowingFirstName: req.body.FollowingFirstName,
                FollowingLastName: req.body.FollowingLastName,
                FollowingProfileImageURL: req.body.FollowingProfileImageURL,
            });
            newFollowing.save(function (err, newFollowing){
                if(err) {
                    res.json({success: false, msg: err})
                }
                else {
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    },

    // Get User Following list
    getUserFollowing: function (req, res) {
        if ((!req.query.Username)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        Following.find({Username: req.query.Username}, function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, body: err})
            } else {
                return res.json({success: true, 
                        Following: response
                    })
            }
        })
    },
}

module.exports = functions