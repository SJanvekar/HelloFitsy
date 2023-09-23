var Class = require('../models/Class')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')

var functions = {

    //Add New Class fnc
    addNewClass: async function (req, res) {
        if ((!req.body.ClassName || !req.body.ClassType || !req.body.ClassPrice)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        var newClass = Class({
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
            ClassTrainerID: req.body.ClassTrainerID,
            Categories: req.body.Categories,
        });
        try {
            await newClass.save()
        } catch (err) {
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, msg: 'Successfully saved'})
    },

    // Get Class Information, can handle arrays
    getClasses: async function (req, res) {
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
            return res.json({success: false, msg: 'Missing query parameter ClassTrainer'});
        }
        const decodedArray = JSON.parse(decodeURIComponent(req.query.ClassTrainer))
        try {
            classArray = await Class.find({ClassTrainerID: {$all:decodedArray}})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: "Failed to find class: " + err})
        }
        return classPromiseAsync(classArray).then( function (parsedResponse) {
            //RESPONSE string is an array of classes
            if (parsedResponse instanceof Error) {
                return res.json({success: false, msg: "Failed to convert response to JSON:" + parsedResponse})
            } else {
                return res.json({success: true, 
                    classArray: parsedResponse,
                })
            }
        })
    },
}

module.exports = functions