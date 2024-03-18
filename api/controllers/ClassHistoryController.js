var ClassHistory = require('../models/ClassHistory')
var jwt = require('jwt-simple')
const { default: mongoose } = require('mongoose');
const { json } = require('body-parser')

var functions = {
    //Add new class history
    addClassHistory: async function (req, res) {
        if ((!req.body.UserID || !req.body.ClassID)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            createAndSaveClassHistoryObject(req.body.UserID,
                req.body.ClassID,
                req.body.DateTaken,
                req.body.TakenStartTimes,
                req.body.IsMissed,
                req.body.IsCancelled);

            res.json({success: true, msg: 'Successfully saved'})
        }
    },

    // Get Class History list
    getClassHistoryList: async function (req, res) {
        const classHistoryPromiseAsync = (responseJSON) => {
            return new Promise((resolve, reject) => {
                let responseString = JSON.stringify(responseJSON)
                var classHistoryArray = ClassHistory()
                classHistoryArray = JSON.parse(responseString)
                if (classHistoryArray) {
                    resolve(classHistoryArray)
                } else {
                    reject(new Error('getClasses returned null'))
                }
            })
        }
        if ((!req.query.UserID)) {
            res.json({success: false, msg: 'Missing query parameter UserID'});
        }
        try {
            response = await ClassHistory.find({UserID: new mongoose.Types.ObjectId(req.query.UserID)})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return classHistoryPromiseAsync(response).then( function (parsedResponse) {
            //RESPONSE string is an array of classes
            if (parsedResponse instanceof Error) {
                return res.json({success: false, msg: "Failed to convert response to JSON:" + parsedResponse})
            } else {
            
                return res.json({success: true, 
                    ClassHistory: response
                })
            }
        })
    },

    createAndSaveClassHistoryObject: async function (UserID, ClassID, DateTaken, TakenStartTimes, IsMissed, IsCancelled) {
        var newClassHistory = ClassHistory({
            UserID: new mongoose.Types.ObjectId(UserID),
            ClassID: new mongoose.Types.ObjectId(ClassID),
            DateTaken: new Date(DateTaken+ 'Z'),
            TakenStartTimes: TakenStartTimes !== null ? TakenStartTimes : [],
            IsMissed: IsMissed !== null ? IsMissed : false,
            IsCancelled: IsCancelled !== null ? IsCancelled : false,
        })

        try {
            response = newClassHistory.save()
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return response;
    },
}

module.exports = functions