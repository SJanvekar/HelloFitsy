var jwt = require('jwt-simple')
const ClassPurchased = require('../models/ClassPurchased');

var functions = {

    //Add New Class fnc
    addNewClassPurchased: function (req, res){
        var newClassPurchased = ClassPurchased({
            StartDate: req.body.StartDate,
            EndDate: req.body.EndDate,
            Recurrence: req.body.Recurrence,
            ClassName: req.body.ClassName,
            ClassImageUrl: req.body.ClassImageUrl,
            ClassType: req.body.ClassType,
            ClassTrainer: req.body.ClassTrainer,
            PurchasedUser: req.body.PurchasedUser,
        });
        newClassPurchased.save(function (err, newClassPurchased){
            if(err){
                res.json({success: false, msg: err})
            }
            else {
                res.json({success: true, msg: 'Successfully saved'})
            }
        })
    },

    // Get Class Information
    getPurchasedClassSchedule: function (req, res) {
        ClassPurchased.find({Class: {$in:req.query.ClassID}}, function (err, classScheduleArray) {
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