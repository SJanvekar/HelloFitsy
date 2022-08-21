var Class = require('../models/class')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')

var functions = {

    //Add New Class fnc
    addNewClass: function (req, res){
        if ((!req.body.ClassName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else{
            var newClass = Class({
                ClassID: req.body.ClassID,
                ClassName: req.body.ClassName,
                ClassDescription: req.body.ClassDescription,
                ClassType: req.body.ClassType,
                ClassLocation: req.body.ClassLocation,
                ClassRating: req.body.ClassRating,
                ClassReview: req.body.ClassReview,
                ClassPrice: req.body.ClassPrice,
                ClassTrainer: req.body.ClassTrainer,
                ClassLiked: req.body.ClassLiked
            });
            newClass.save(function (err, newClass){
                if(err){
                    res.json({success: false, msg: err})
                }
                else {
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    },

    // Get Class Information
    getinfo: function (req, res){
    },

    testing: function (req, res){
        if  ((!req.body.UserType) || (!req.body.FirstName) || (!req.body.LastName) || (!req.body.Username) || (!req.body.UserEmail) || (!req.body.Password)){
            res.json({success: false, msg: 'Enter all fields'})
        }
        else{
            var newUser = User({
                UserID: req.body.UserID,
                UserType: req.body.UserType,
                FirstName: req.body.FirstName,
                LastName: req.body.LastName,
                Username: req.body.Username,
                UserEmail: req.body.UserEmail,
                Password: req.body.Password

            });
            newUser.save(function (err, newUser){
                if(err){
                    res.json({success: false, msg: 'Failed to save'})
                }
                else {
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    },
}

module.exports = functions