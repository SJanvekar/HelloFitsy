var Class = require('../models/class')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')

var functions = {

    //Add New Class fnc
    addNewClass: function (req, res){
        if ((!req.body.ClassName || !req.body.ClassType || !req.body.ClassPrice)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else{
            var newClass = Class({
                ClassID: req.body.ClassID,
                ClassName: req.body.ClassName,
                ClassImageUrl: req.body.ClassImageUrl,
                ClassDescription: req.body.ClassDescription,
                ClassWhatToExpect: req.body.ClassWhatToExpect,
                ClassUserRequirements: req.body.ClassUserRequirements,
                ClassType: req.body.ClassType,
                ClassLocation: req.body.ClassLocation,
                ClassRating: req.body.ClassRating,
                ClassReview: req.body.ClassReview,
                ClassPrice: req.body.ClassPrice,
                ClassTrainer: req.body.ClassTrainer,
                ClassLiked: req.body.ClassLiked,
                ClassTimes: req.body.ClassTimes,
                Categories: req.body.Categories,
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
    getClasses: function (req, res) {
        const classPromiseAsync = (responseJSON) => {
            return new Promise((resolve, reject) => {
                let responseString = JSON.stringify(responseJSON)
                var classArray = Class()
                classArray = JSON.parse(responseString)
                if (classArray) {
                    resolve(classArray)
                } else {
                    reject(new Error('getClasses returned null'))
                }
            })
        }
        if  ((!req.query.ClassTrainer)) { //TODO: Check aganist empty and null query parameters, also apply to similar checks
            res.json({success: false, msg: 'Missing query parameter ClassTrainer'});
        }
        Class.find({ClassTrainer: {$in:req.query.ClassTrainer}}, function (err, classArray) {
            if (err) {
                console.log(err)
                return res.json({success: false, body: err})
            } else {
                return classPromiseAsync(classArray).then(parsedResponse => 
                    //RESPONSE string is an array of classes
                    res.json({success: true, 
                        classArray: parsedResponse,
                    }))
            }
        })
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