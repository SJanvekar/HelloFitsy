var Following = require('../models/Following')
var jwt = require('jwt-simple')
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
        if ((!req.body.Username || !req.body.FollowingUserName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            Following.deleteOne({$and:[{'Username': req.body.Username} , {'FollowingUsername': req.body.FollowingUserName}]}, function (err, deletedFollowing){
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
        if ((!req.query.Username)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        Following.find({Username: req.query.Username}, function (err, response) {
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