var ClassLiked = require('../models/ClassLiked')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')
const { default: mongoose } = require('mongoose')

var functions = {
    //Add liked class
    addClassLiked: function (req, res) {
        console.log("Running add")
        if ((!req.body.UserName || !req.body.ClassID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            var newClassLiked= ClassLiked({
                Username: req.body.UserName,
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
        if ((!req.body.UserName || !req.body.ClassID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            ClassLiked.deleteOne({Username: req.body.UserName, ClassID: mongoose.Types.ObjectId(req.body.ClassID)}, function (err){
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
        if ((!req.query.UserName || !req.query.ClassID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            ClassLiked.findOne({Username: req.query.UserName, ClassID: mongoose.Types.ObjectId(req.query.ClassID)}, function (err, response) {
                if (err) {
                    console.log(err)
                    return res.json({success: false, msg: err})
                } else {
                    console.log(response)
                    return res.json({success: true, result: !!response})
                }
            })
        }
    },

    // Get liked class list
    getClassLikedList: function (req, res) {
        if ((!req.query.UserName)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        ClassLiked.find({Username: req.query.UserName}, function (err, response) {
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