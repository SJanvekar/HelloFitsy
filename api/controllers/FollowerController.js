var Follower = require('../models/Follower')
var jwt = require('jwt-simple')
const { json } = require('body-parser')

var functions = {
    //Add New Follower
    addFollower: async function (req, res) {
        if ((!req.body.UserID || !req.body.FollowerUserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        var newFollower = Follower({
            FollowerUserID: req.body.FollowerUserID,
            UserID: req.body.UserID,
        });
        try {
            await newFollower.save()
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        console.log("Successfully saved Follower")
        return res.json({success: true})
    },

    //Remove Follower
    removeFollower: async function (req, res) {
        if ((!req.body.UserID || !req.body.FollowerUserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            deletedFollower = await Follower.deleteOne({$and:[
                {'UserID': req.body.UserID} , 
                {'FollowerUserID': req.body.FollowerUserID}]})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        if (!deletedFollower) {
            return res.json({success: false, msg: "Something went horribly wrong"})
        } else {
            console.log("Successfully removed Follower" + deletedFollower)
            return res.json({success: true})
        }
    },

    //Is current user follower account
    isFollower: async function (req, res) {
        if ((!req.body.UserID || !req.body.FollowerUserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            foundFollower = await Follower.findOne({$and:[{'UserID': req.body.UserID} , {'FollowerUserID': req.body.FollowerUserID}]})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        if (foundFollower) {
            console.log("Successfully found one Follower" + foundFollower)
            return res.json({success: true, found: true})
        } else {
            console.log("Successfully found no Follower" + foundFollower)
            return res.json({success: true, found: false})
        }
    },

    // Get User Follower list
    getUserFollower: async function (req, res) {
        if ((!req.query.UserID)) {
            return res.json({success: false, msg: 'Missing query parameter Username'});
        }
        try {
            response = await Follower.find({UserID: req.query.UserID})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, 
            follower: response
        })
    },
}

module.exports = functions