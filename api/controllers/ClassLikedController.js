var ClassLiked = require('../models/ClassLiked')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')
const { default: mongoose } = require('mongoose')

var functions = {
    //Add liked class
    addClassLiked: function (req, res) {
        console.log("Running add")
        if ((!req.body.UserID || !req.body.ClassID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            var newClassLiked= ClassLiked({
                UserID: req.body.UserID,
                ClassID: req.body.ClassID,
            });
            newClassLiked.save(function (err, newClassLiked){
                if (err) {
                    console.log(err)
                    res.json({success: false, msg: err})
                }
                else {
                    res.json({success: true, msg: 'Successfully added class liked', liked: true})
                }
            })
        }
    },

    //Remove liked class
    removeClassLiked: function (req, res) {
        console.log("Running remove")
        if ((!req.body.UserID || !req.body.ClassID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            ClassLiked.deleteOne({UserID: mongoose.Types.ObjectId(req.body.UserID), ClassID: mongoose.Types.ObjectId(req.body.ClassID)}, function (err){
                if (err) {
                    console.log(err)
                    res.json({success: false, msg: err})
                }
                else {
                    res.json({success: true, msg: 'Successfully removed class liked', liked: false})
                }
            })
        }
    },

    isLiked: function (req, res) {
        if ((!req.query.UserID || !req.query.ClassID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            ClassLiked.findOne({UserID: mongoose.Types.ObjectId(req.query.UserID), ClassID: mongoose.Types.ObjectId(req.query.ClassID)}, function (err, response) {
                if (err && err.code != 11000) {
                    console.log(err)
                    return res.json({success: false, msg: err, errorCode: err.code})
                } else {
                    return res.json({success: true, result: !!response})
                }
            })
        }
    },

    // Get liked class list
    getClassLikedList: function (req, res) {
        if ((!req.query.UserID)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        ClassLiked.find({UserID: mongoose.Types.ObjectId(req.query.UserID)}, function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, msg: err})
            } else {
                return res.json({success: true, 
                        ClassLiked: response
                    })
            }
        })
    },
}

module.exports = functions