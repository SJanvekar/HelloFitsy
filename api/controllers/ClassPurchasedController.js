var jwt = require('jwt-simple')
const ClassPurchased = require('../models/ClassPurchased');

var functions = {

    //Add New Class fnc
    addNewClassPurchased: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID || !req.body.StartDate)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        const newClassTimes = {
            //Add Z for signalling UTC time
            StartDate: new Date(req.body.StartDate + 'Z'),
            EndDate: new Date(req.body.EndDate + 'Z'),
            Recurrence: req.body.Recurrence,
        }
        var newClassPurchased = ClassPurchased({
            ClassID: req.body.ClassID,
            UserID: req.body.UserID,
            ClassTimes: newClassTimes,
        });
        try {
            await newClassPurchased.save()
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        console.log("Successfully saved Class Purchased")
        return res.json({success: true})
    },

    // Get Class Information
    getClassPurchased: async function (req, res) {
        if ((!req.query.ClassID || !req.query.UserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            classPurchasedArray = await ClassPurchased.find({$and:[
                {'UserID': new mongoose.Types.ObjectId(req.query.UserID)} , 
                {'ClassID': new mongoose.Types.ObjectId(req.query.ClassID)}]})
        } catch (err) { 
            console.log(err)
            return res.json({success: false, msg: err})
        }
        if (classPurchasedArray && classPurchasedArray.length > 0) {
            console.log("Successfully found Purchased classes")
            return res.json({success: true, classPurchased: classPurchasedArray})
        } else {
            console.log("Something strange happened or there's no purchased classes")
            return res.json({success: false, msg: "Couldn't get purchased classes"})
        }
    },
}

module.exports = functions