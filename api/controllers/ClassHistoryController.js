var ClassHistory = require('../models/ClassHistory')
var jwt = require('jwt-simple')
const { json } = require('body-parser')

var functions = {
    //Add new class history
    addClassHistory: function (req, res) {
        if ((!req.body.UserName || !req.body.ClassName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            var newClassHistory= ClassHistory({
                UserName: req.body.UserName,
                ClassName: req.body.ClassName,
                ClassImageUrl: req.body.ClassImageUrl,
                ClassType: req.body.ClassType,
                ClassLocation: req.body.ClassLocation,
                ClassTrainer: req.body.ClassTrainer,
                TrainerImageUrl: req.body.TrainerImageUrl,
                TrainerFirstName: req.body.TrainerFirstName,
                TrainerLastName: req.body.TrainerLastName,
            });
            newClassHistory.save(function (err, newClassHistory){
                if(err) {
                    res.json({success: false, msg: err})
                }
                else {
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    },

    // Get Class History list
    getClassHistoryList: function (req, res) {
        if ((!req.query.UserName)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        ClassLiked.find({Username: req.query.UserName}, function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, msg: err})
            } else {
                return res.json({success: true, 
                        ClassHistory: response
                    })
            }
        })
    },
}

module.exports = functions