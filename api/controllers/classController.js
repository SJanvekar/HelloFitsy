var Class = require('../models/user')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')

var functions = {

    //Add New Class fnc
    addNew: function (req, res){
        if  ((!req.body.ClassType) || (!req.body.ClassLocation) || (!req.body.ClassRating) || 
        (!req.body.ClassReview) || (!req.body.ClassPrice) || (!req.body.ClassTrainer) || (!req.body.ClassLiked)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else{
            var newClass = Class({
                ClassID: req.body.ClassID,
                ClassType: req.body.ClassType,
                ClassLocation: req.body.ClassLocation,
                ClassRating: req.body.ClassRating,
                ClassReview: req.body.ClassReview,
                ClassPrice: req.body.ClassPrice,
                ClassTrainer: req.body.ClassTrainer,
                ClassLiked: req.body.ClassLiked
            });
            newClass.save(function (err, newUser){
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
        if(req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer'){
            var token = req.headers.authorization.split(' ')[1]
            var decodedtoken = jwt.decode(token, config.secret)
            return res.json({success: true, msg: 'Hello ' + decodedtoken.FirstName })
        }else {
            return res.json({success: false, msg: 'No Headers'})
        }
    }
}

module.exports = functions