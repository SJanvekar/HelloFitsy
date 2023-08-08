var ClassSchedule = require('../models/ClassSchedule')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')

var functions = {

    //Add New Class fnc
    addNewClassSchedule: function (req, res){
        var newClassSchedule = ClassSchedule({
            StartDate: req.body.StartDate,
            EndDate: req.body.EndDate,
            Recurrence: req.body.Recurrence,
            ClassName: req.body.ClassName,
            ClassImageUrl: req.body.ClassImageUrl,
            ClassType: req.body.ClassType,
            ClassTrainer: req.body.ClassTrainer,
            PurchasedUser: req.body.PurchasedUser,
        });
        newClassSchedule.save(function (err, newClassSchedule){
            if(err){
                res.json({success: false, msg: err})
            }
            else {
                res.json({success: true, msg: 'Successfully saved'})
            }
        })
    },

    // Get Class Information
    getClassSchedule: function (req, res) {
        ClassSchedule.find({Class: {$in:req.query.ClassID}}, function (err, classScheduleArray) {
            if (err) {
                console.log(err)
                return res.json({success: false, msg: err})
            } else {
                return classPromiseAsync(classScheduleArray).then(parsedResponse => 
                    //RESPONSE string is an array of classes
                    res.json({success: true, 
                        classScheduleArray: parsedResponse,
                    }))
            }
        })
    },
}

module.exports = functions