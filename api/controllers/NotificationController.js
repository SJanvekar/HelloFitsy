// var Notification = require('../models/Notification')
const admin = require('firebase-admin');
const firebaseMessaging = require('firebase-admin/messaging');

const app = admin.initializeApp({
    credential: admin.credential.cert(process.env.GOOGLE_APPLICATION_CREDENTIALS),
});

var functions = {
    //Add Upcoming Class Schedule Notification
    // addScheduleNotification: async function (req, res) {
    //     if ((!req.body.UserID || !req.body.FollowingUserID)) {
    //         return res.json({success: false, msg: 'Missing Information'})
    //     }
        
    //     firebaseMessaging.getMessaging(app).send(message)
    //         .then((response) => {
    //             // Response is a message ID string.
    //             console.log('Successfully sent message:', response);
    //         })
    //         .catch((error) => {
    //             console.log('Error sending message:', error);
    //         });
    // },

    //Add Test Notification
    addTestNotification: async function (req, res) {
        // if ((!req.body.UserID || !req.body.FollowingUserID)) {
        //     return res.json({success: false, msg: 'Missing Information'})
        // }


        setTimeout(() => {
            console.log('This code runs after 5 seconds');
          }, 5000);
          
        const registrationToken = req.body.RegistrationToken;

        const message = {
            notification: {
                title: 'Test notification sent by nodeJS server',
                body: 'I can not believe this worked',
            },
            token: registrationToken
        };
        
        firebaseMessaging.getMessaging(app).send(message)
            .then((response) => {
                // Response is a message ID string.
                
                res.json({success: true, msg: response})
            })
            .catch((error) => {
                
                res.json({success: false, msg: error})
            });
    },
}

module.exports = functions