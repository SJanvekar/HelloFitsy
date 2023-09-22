var Following = require('../models/Following')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')

var functions = {
    //Add New Following
    addFollowing: function (req, res) {
        if ((!req.body.UserID || !req.body.FollowingUserID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            var newFollowing = Following({
                FollowingUserID: req.body.FollowingUserID,
                UserID: req.body.UserID,
            });
            newFollowing.save(function (err, newFollowing){
                if (err) {
                    console.log(err)
                    res.json({success: false, msg: err})
                }
                else {
                    console.log("Successfully saved Following")
                    res.json({success: true})
                }
            })
        }
    },

    //Remove Following
    removeFollowing: function (req, res) {
        if ((!req.body.UserID || !req.body.FollowingUserID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            Following.deleteOne({$and:[{'UserID': req.body.UserID} , 
            {'FollowingUserID': req.body.FollowingUserID}]}, function (err, deletedFollowing){
                if (err || !deletedFollowing) {
                    console.log(err)
                    res.json({success: false, msg: err})
                }
                else {
                    console.log("Successfully removed Following" + deletedFollowing)
                    res.json({success: true})
                }
            })
        }
    },

    //Is current user following account
    isFollowing: function (req, res) {
        if ((!req.body.Username || !req.body.FollowingUserName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            Following.findOne({$and:[{'Username': req.body.Username} , {'FollowingUsername': req.body.FollowingUserName}]}, function (err, foundFollowing){
                if (err) {
                    console.log(err)
                    res.json({success: false, msg: err})
                }
                else {
                    if (foundFollowing) {
                        console.log("Successfully found one Following" + foundFollowing)
                        res.json({success: true, found: true})
                    } else {
                        console.log("Successfully found no Following" + foundFollowing)
                        res.json({success: true, found: false})
                    }
                }
            })
        }
    },

    // Get User Following list
    getUserFollowing: function (req, res) {
        if ((!req.query.UserID)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        Following.find({UserID: req.query.UserID}, function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, msg: err})
            } else {
                return res.json({success: true, 
                        following: response
                    })
            }
        })
    },
}

module.exports = functions