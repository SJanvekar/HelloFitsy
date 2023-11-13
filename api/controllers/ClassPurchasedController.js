var jwt = require('jwt-simple')
const ClassPurchased = require('../models/ClassPurchased');
const { default: mongoose } = require('mongoose');

var functions = {
    //Add New Class Purchased
    addNewClassPurchased: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID || !req.body.StartDate || !req.body.EndDate || !req.body.DateBooked || !req.body.PricePaid)) {
            return res.json({success: false, msg: 'Missing Information'}) 
        }
        const newClassTimes = {
            //Add Z for signalling UTC time
            StartDate: new Date(req.body.StartDate + 'Z'),
            EndDate: new Date(req.body.EndDate + 'Z'),
        }
        var newClassPurchased = ClassPurchased({
            ClassID: new mongoose.Types.ObjectId(req.body.ClassID),
            UserID: new mongoose.Types.ObjectId(req.body.UserID),
            ClassTimes: newClassTimes,
            DateBooked: new Date(req.body.DateBooked + 'Z'),
            PricePaid: req.body.PricePaid
        });
        try {
            await newClassPurchased.save()
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        return res.json({success: true})
    },

    //Add Class Purchased Updated Schedule
    addClassPurchasedUpdatedSchedule: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID || !req.body.StartDate || !req.body.EndDate || !req.body.ScheduleReference)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        const newClassTimes = {
            //Add Z for signalling UTC time
            StartDate: new Date(req.body.StartDate + 'Z'),
            EndDate: new Date(req.body.EndDate + 'Z'),
            ScheduleReference: req.body.ScheduleReference
        }
        try {
            result = await ClassPurchased.updateOne({ClassID: new mongoose.Types.ObjectId(req.body.ClassID),
                UserID: new mongoose.Types.ObjectId(req.body.UserID)}, {$push: { UpdatedClassTimes: newClassTimes }} )
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        //Success bool determined if matched and modified doc are both value 1
        return res.json({success: ((result.matchedCount === 1 && result.modifiedCount === 1) ? true : false), 
            msg: result})
    },

    //Change Class Purchased Updated Schedule
    changeClassPurchasedUpdatedSchedule: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID || !req.body.ScheduleID || !req.body.StartDate || !req.body.EndDate || !req.body.ScheduleReference)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        const newClassTimes = {
            //Add Z for signalling UTC time
            StartDate: new Date(req.body.StartDate + 'Z'),
            EndDate: new Date(req.body.EndDate + 'Z'),
            ScheduleReference: req.body.ScheduleReference
        }
        try {
            result = await ClassPurchased.updateOne({
                ClassID: new mongoose.Types.ObjectId(req.body.ClassID),
                UserID: new mongoose.Types.ObjectId(req.body.UserID), 
                'UpdatedClassTimes._id': new mongoose.Types.ObjectId(req.body.ScheduleID)
            }, {$set: { 'UpdatedClassTimes.$': newClassTimes }} )
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        //Success bool determined if matched and modified doc are both value 1
        return res.json({success: ((result.matchedCount === 1 && result.modifiedCount === 1) ? true : false), 
            msg: result})
    },

    //Add Class Purchased Cancelled Schedule
    addClassPurchasedCancelledSchedule: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID || !req.body.StartDate || !req.body.EndDate || !req.body.ScheduleReference)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        const newClassTimes = {
            //Add Z for signalling UTC time
            StartDate: new Date(req.body.StartDate + 'Z'),
            EndDate: new Date(req.body.EndDate + 'Z'),
            ScheduleReference: req.body.ScheduleReference
        }
        try {
            result = await ClassPurchased.updateOne({ClassID: new mongoose.Types.ObjectId(req.body.ClassID),
                UserID: new mongoose.Types.ObjectId(req.body.UserID)}, {$push: { UpdatedClassTimes: newClassTimes }} )
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        //Success bool determined if matched and modified doc are both value 1
        return res.json({success: ((result.matchedCount === 1 && result.modifiedCount === 1) ? true : false), 
            msg: result})
    },

    //Add Class Purchased Missed
    addClassPurchasedMissed: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            result = await ClassPurchased.updateOne({ClassID: new mongoose.Types.ObjectId(req.body.ClassID),
                UserID: new mongoose.Types.ObjectId(req.body.UserID)}, {$set: { IsMissed: true }} )
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        //Success bool determined if matched and modified doc are both value 1
        return res.json({success: ((result.matchedCount === 1 && result.modifiedCount === 1) ? true : false), 
            msg: result})
    },

    //Add Class Purchased Cancelled
    addClassPurchasedCancelled: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            result = await ClassPurchased.updateOne({ClassID: new mongoose.Types.ObjectId(req.body.ClassID),
                UserID: new mongoose.Types.ObjectId(req.body.UserID)}, {$set: { IsCancelled: true }} )
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        //Success bool determined if matched and modified doc are both value 1
        return res.json({success: ((result.matchedCount === 1 && result.modifiedCount === 1) ? true : false), 
            msg: result})
    },

    //Add New Class Cancellation Reason
    addClassPurchasedCancelReason: async function (req, res) {
        if ((!req.body.ClassID || !req.body.UserID || !req.body.CancellationReason)) {
            return res.json({success: false, msg: 'Missing Information'})
        }
        try {
            result = await ClassPurchased.updateOne({ClassID: new mongoose.Types.ObjectId(req.body.ClassID),
                UserID: new mongoose.Types.ObjectId(req.body.UserID)}, {$set: { CancellationReason: req.body.CancellationReason }} )
        } catch (err) {
            console.log(err)
            return res.json({success: false, msg: err})
        }
        //Success bool determined if matched and modified doc are both value 1
        return res.json({success: ((result.matchedCount === 1 && result.modifiedCount === 1) ? true : false), 
            msg: result})
    },

    // Get Class Information
    getClassPurchased: async function (req, res) {
        if (!req.query.ClassID && !req.query.UserID) { //Both are missing, one ID is required
            return res.json({success: false, msg: 'Missing Information'})
        } else if (req.query.ClassID && !req.query.UserID) { //ClassID exists but not UserID
            const query = await ClassPurchased.find({
                'ClassID': new mongoose.Types.ObjectId(req.query.ClassID)}
            );
        } else if (!req.query.ClassID && req.query.UserID) { //UserID exists but not ClassID
            const query = await ClassPurchased.find({
                'UserID': new mongoose.Types.ObjectId(req.query.UserID)}
            );
        } else { //Both ClassID and UserID existsconst query = await ClassPurchased.find({
            const query = await ClassPurchased.find({
                $and: [
                    {'UserID': new mongoose.Types.ObjectId(req.query.UserID)},
                    {'ClassID': new mongoose.Types.ObjectId(req.query.ClassID)}
                ]
            });
        }

        try {
            classPurchasedArray = await ClassPurchased.find(query)
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