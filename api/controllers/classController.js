var Class = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')

var functions = {

    //Add New Class fnc
    addNewClass: function (req, res){
        print("FUCK");
        if  ((!req.body.ClassType) || (!req.body.ClassLocation) || (!req.body.ClassRating) || 
        (!req.body.ClassReview) || (!req.body.ClassPrice) || (!req.body.ClassTrainer) || (!req.body.ClassLiked)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else{
            print("FUCK");
            var newClass = Class({
                ClassID: req.body.ClassID,
                ClassName: req.body.ClassName,
                // ClassType: req.body.ClassType,
                // ClassLocation: req.body.ClassLocation,
                // ClassRating: req.body.ClassRating,
                // ClassReview: req.body.ClassReview,
                // ClassPrice: req.body.ClassPrice,
                // ClassTrainer: req.body.ClassTrainer,
                // ClassLiked: req.body.ClassLiked
            });
            newClass.save(function (err, newClass){
                if(err){
                    res.json({success: false, msg: 'Failed to save'})
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
}

module.exports = functions