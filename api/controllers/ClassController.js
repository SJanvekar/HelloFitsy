var Class = require('../models/Class')
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
                ClassLocationName: req.body.ClassLocationName,
                ClassLatitude: req.body.ClassLatitude,
                ClassLongitude: req.body.ClassLongitude,
                ClassOverallRating: req.body.ClassOverallRating,
                ClassReviewsAmount: req.body.ClassReviewsAmount,
                ClassPrice: req.body.ClassPrice,
                ClassTrainer: req.body.ClassTrainer,
                ClassLiked: req.body.ClassLiked,
                ClassTimes: req.body.ClassTimes,
                Categories: req.body.Categories,
                TrainerImageUrl: req.body.TrainerImageUrl,
                TrainerFirstName: req.body.TrainerFirstName,
                TrainerLastName: req.body.TrainerLastName,
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
                return res.json({success: false, msg: err})
            } else {
                return classPromiseAsync(classArray).then(parsedResponse => 
                    //RESPONSE string is an array of classes
                    res.json({success: true, 
                        classArray: parsedResponse,
                    }))
            }
        })
    },
}

module.exports = functions