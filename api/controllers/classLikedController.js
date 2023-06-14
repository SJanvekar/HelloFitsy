var ClassLiked = require('../models/classLiked')
var jwt = require('jwt-simple')
var config = require('../../config/Private/dbconfig')
const { json } = require('body-parser')

var functions = {
    //Add liked class
    addClassLiked: function (req, res) {
        if ((!req.body.UserName || !req.body.ClassName)) {
            res.json({success: false, msg: 'Missing Information'})
        }
        else {
            var newClassLiked= ClassLiked({
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
            newClassLiked.save(function (err, newClassLiked){
                if(err) {
                    res.json({success: false, msg: err})
                }
                else {
                    res.json({success: true, msg: 'Successfully saved'})
                }
            })
        }
    },

    // Get liked class list
    getClassLikedList: function (req, res) {
        if ((!req.query.UserName)) {
            res.json({success: false, msg: 'Missing query parameter Username'});
        }
        ClassLiked.find({Username: req.query.UserName}, function (err, response) {
            if (err) {
                console.log(err)
                return res.json({success: false, body: err})
            } else {
                return res.json({success: true, 
                        ClassLiked: response
                    })
            }
        })
    },
}

module.exports = functions