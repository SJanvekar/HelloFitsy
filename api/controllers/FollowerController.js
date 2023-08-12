var Follower = require('../models/Follower')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')

var functions = {
    //Add New Follower
    addFollower: function (req, res) {
        if ((!req.body.Username || !req.body.FollowerUserName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            var newFollower = Follower({
                FollowerUsername: req.body.FollowerUserName,
                Username: req.body.Username,
                FollowerFirstName: req.body.FollowerFirstName,
                FollowerLastName: req.body.FollowerLastName,
                FollowerProfileImageURL: req.body.FollowerProfileImageURL,
            });
            newFollower.save(function (err, newFollower){
                if (err) {
                    console.log(err)
                    res.json({success: false, msg: err})
                }
                else {
                    console.log("Successfully saved Follower")
                    res.json({success: true})
                }
            })
        }
    },

    //Remove Follower
    removeFollower: function (req, res) {
        if ((!req.body.Username || !req.body.FollowerUserName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            Follower.deleteOne({$and:[{'Username': req.body.Username} , {'FollowerUsername': req.body.FollowerUserName}]}, function (err, deletedFollower){
                if (err || !deletedFollower) {
                    console.log(err)
                    res.json({success: false, msg: err})
                }
                else {
                    console.log("Successfully removed Follower" + deletedFollower)
                    res.json({success: true})
                }
            })
        }
    },

    // Get User Follower list
    getUserFollower: function (req, res) {
        if ((!req.query.Username)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        Follower.find({Username: req.query.Username}, function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, msg: err})
            } else {
                return res.json({success: true, 
                        Follower: response
                    })
            }
        })
    },
}

module.exports = functions