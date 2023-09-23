var ClassLiked = require('../models/ClassLiked')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')
const { default: mongoose } = require('mongoose')

var functions = {
    //Add liked class
    addClassLiked: async function (req, res) {
        console.log("Running add")
        if ((!req.body.UserID || !req.body.ClassID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        var newClassLiked= ClassLiked({
            UserID: req.body.UserID,
            ClassID: req.body.ClassID,
        });
        try {
            await newClassLiked.save()
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, msg: 'Successfully added class liked', liked: true})
    },

    //Remove liked class
    removeClassLiked: async function (req, res) {
        console.log("Running remove")
        if ((!req.body.UserID || !req.body.ClassID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            await ClassLiked.deleteOne({UserID: new mongoose.Types.ObjectId(req.body.UserID), 
                                        ClassID: new mongoose.Types.ObjectId(req.body.ClassID)})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, msg: 'Successfully removed class liked', liked: false})
    },

    isLiked: async function (req, res) {
        if ((!req.query.UserID || !req.query.ClassID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            response = await ClassLiked.findOne({UserID: new mongoose.Types.ObjectId(req.query.UserID), 
                                                ClassID: new mongoose.Types.ObjectId(req.query.ClassID)})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err, errorCode: err.code})
        }
        return res.json({success: true, result: !!response})
    },

    // Get liked class list
    getClassLikedList: async function (req, res) {
        if ((!req.query.UserID)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        try {
            response = await ClassLiked.find({UserID: new mongoose.Types.ObjectId(req.query.UserID)})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, 
            ClassLiked: response
        })
    },
}

module.exports = functions