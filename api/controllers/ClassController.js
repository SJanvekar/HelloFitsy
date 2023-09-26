const { default: mongoose } = require('mongoose')
var Class = require('../models/Class')
const Schedule = require('../models/Schedule')
// var jwt = require('jwt-simple')

var functions = {

    //*****GET REQUESTS*****//

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

    // Search Classes
    searchClasses: async function (req, res) {
        try {
            response = await Class.aggregate([
                {$search: {
                    index: 'ClassName',
                    text: {
                        query: req.query.SearchIndex,
                        path: 'ClassName',
                        fuzzy: {}
                    }
                }},
            ])
        } catch (err) {
            console.log(err)
            return res.json({success: false, errorCode: err.code})
        }
        return res.json({success: true, searchResults: response})
    },

    //*****POST REQUESTS*****//

    //Add New Class function
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
        return res.json({success: true, msg: 'Successfully saved class'})
    },

    //Add New Schedule function
    addClassTimes: async function (req, res) {
        if ((!req.body.ClassTrainerID || !req.body.StartDate || !req.body.EndDate || !req.body.Recurrence)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        const newClassTimes = {
            //Add Z for signalling UTC time
            StartDate: new Date(req.body.StartDate + 'Z'),
            EndDate: new Date(req.body.EndDate + 'Z'),
            Recurrence: req.body.Recurrence,
        }
        try {
            result = await Class.updateOne(
                {ClassTrainerID: new mongoose.Types.ObjectId(req.body.ClassTrainerID)},
                { $push: { ClassTimes: newClassTimes } })
        } catch (err) {
            return res.json({success: false, msg: err})
        }
        //Success bool determined if matched and modified doc are both value 1
        return res.json({success: ((result.matchedCount === 1 && result.modifiedCount === 1) ? true : false), 
                        msg: result})
        // return res.json({success: true, msg: 'Successfully added class schedule'})
    },

    //Change New Schedule function
    changeClassTimes: async function (req, res) {
        if ((!req.body.ClassTrainerID || !req.body.NewStartDate || !req.body.NewEndDate || !req.body.NewRecurrence)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        const newClassTimes = {
            StartDate: req.body.NewStartDate,
            EndDate: req.body.NewEndDate,
            Recurrence: req.body.NewRecurrence,
        }
        //Filtering based off of exact match for subfields in ClassTimes
        const filterConditions = {
            $and: [
              {'ClassTimes.StartDate': req.body.OldStartDate},
              {'ClassTimes.EndDate': req.body.OldEndDate},
              {'ClassTimes.Recurrence': req.body.OldRecurrence},
            ],
          }
        try {
            await Class.findOneAndUpdate(
                {ClassTrainerID: new mongoose.Types.ObjectId(req.body.ClassTrainerID)},
                {$push: { ClassTimes: newClassTimes}},
                filterConditions)
        } catch (err) {
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, msg: 'Successfully changed class schedule'})
    },

    //Remove Schedule function
    removeClassTimes: async function (req, res) {
        if ((!req.body.ClassTrainerID || !req.body.StartDate || !req.body.EndDate || !req.body.Recurrence)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        const newClassTimes = {
            StartDate: req.body.StartDate,
            EndDate: req.body.EndDate,
            Recurrence: req.body.Recurrence,
        }
        try {
            await Class.updateOne(
                {ClassTrainerID: new mongoose.Types.ObjectId(req.body.ClassTrainerID)},
                { $pull: { ClassTimes: newClassTimes } })
        } catch (err) {
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, msg: 'Successfully removed class schedule'})
    },
}

module.exports = functions