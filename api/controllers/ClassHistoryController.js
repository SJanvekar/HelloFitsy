var ClassHistory = require('../models/ClassHistory')
var jwt = require('jwt-simple')
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
        if ((!req.query.UserName)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        try {
            response = await Classistory.find({UserID: new mongoose.Types.ObjectId(req.query.UserID)})
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return res.json({success: true, 
            ClassHistory: response
        })
    },

    createAndSaveClassHistoryObject: async function (UserID, ClassID, DateTaken, TakenStartTimes, IsMissed, IsCancelled) {
        var newClassHistory = ClassHistory({
            UserID: UserID,
            ClassID: ClassID,
            DateTaken: DateTaken,
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