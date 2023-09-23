var Following = require('../models/Following')
var jwt = require('jwt-simple')
const { json } = require('body-parser')

var functions = {
    //Add New Following
    addFollowing: async function (req, res) {
        if ((!req.body.UserID || !req.body.FollowingUserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        var newFollowing = Following({
            FollowingUserID: req.body.FollowingUserID,
            UserID: req.body.UserID,
        });
        try {
            await newFollowing.save()
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        console.log("Successfully saved Following")
        return res.json({success: true})
    },

    //Remove Following
    removeFollowing: async function (req, res) {
        if ((!req.body.UserID || !req.body.FollowingUserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            deletedFollowing = await Following.deleteOne({$and:[
                {'UserID': req.body.UserID} , 
                {'FollowingUserID': req.body.FollowingUserID}]})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        if (!deletedFollowing) {
            return res.json({success: false, msg: "Something went horribly wrong"})
        } else {
            console.log("Successfully removed Following" + deletedFollowing)
            return res.json({success: true})
        }
    },

    //Is current user following account
    isFollowing: async function (req, res) {
        if ((!req.body.UserID || !req.body.FollowingUserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            foundFollowing = await Following.findOne({$and:[{'UserID': req.body.UserID} , {'FollowingUserID': req.body.FollowingUserID}]})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        if (foundFollowing) {
            console.log("Successfully found one Following" + foundFollowing)
            return res.json({success: true, found: true})
        } else {
            console.log("Successfully found no Following" + foundFollowing)
            return res.json({success: true, found: false})
        }
    },

    // Get User Following list
    getUserFollowing: async function (req, res) {
        if ((!req.query.UserID)) {
            return res.json({success: false, msg: 'Missing query parameter Username'});
        }
        try {
            response = await Following.find({UserID: req.query.UserID})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, 
            following: response
        })
    },
}

module.exports = functions