// // var Notification = require('../models/Notification')
// const admin = require('firebase-admin');
// const firebaseMessaging = require('firebase-admin/messaging');

// const app = admin.initializeApp({
//     credential: admin.credential.cert(process.env.GOOGLE_APPLICATION_CREDENTIALS),
// });

// var functions = {
//     //Add Upcoming Class Schedule Notification
//     // addScheduleNotification: async function (req, res) {
//     //     if ((!req.body.UserID || !req.body.FollowingUserID)) {
//     //         return res.json({success: false, msg: 'Missing Information'})
//     //     }
        
//     //     firebaseMessaging.getMessaging(app).send(message)
//     //         .then((response) => {
//     //             // Response is a message ID string.
//     //             console.log('Successfully sent message:', response);
//     //         })
//     //         .catch((error) => {
//     //             console.log('Error sending message:', error);
//     //         });
//     // },

//     //Add Test Notification
//     addTestNotification: async function (req, res) {
//         // if ((!req.body.UserID || !req.body.FollowingUserID)) {
//         //     return res.json({success: false, msg: 'Missing Information'})
//         // }


//         setTimeout(() => {
//             console.log('This code runs after 5 seconds');
//           }, 15000);

//         const registrationToken = req.body.RegistrationToken;

//         const message = {
//             notification: {
//                 title: 'Test notification sent by nodeJS server',
//                 body: 'I can not believe this worked',
//             },
//             token: 'd9a12_ew1Umsl2xZ2MaHI4:APA91bGcRkM7I55RyvmMq1RZO0VZzfTgJRDaFSPqj3n2DVAGE3KN-CWJRpJnN5Z9Mdxj-NVNb2jxfjvZTxpkIyf0Q9oJIi7DjX6N5vQXpT6MLs9ssRFWvGzdCstdsFYFOIvhYYPqdd5E'
//         };

//         // Calculate the date and time 10 minutes from now
//         const now = new Date();
//         const scheduledDate = new Date(now.getTime() + 10 * 60 * 1000); // 10 minutes from now

//         // Format the cron expression for the scheduled date and time
//         const cronExpression = `${scheduledDate.getMinutes()} ${scheduledDate.getHours()} 
//         ${scheduledDate.getDate()} ${scheduledDate.getMonth() + 1} *`;

//         // Schedule the task
//         const scheduledJob = cron.schedule(cronExpression, async () => {
//             firebaseMessaging.getMessaging(app).send(message)
//             .then((response) => {
//                 // Response is a message ID string.
                
//                 res.json({success: true, msg: response})
//             })
//             .catch((error) => {
                
//                 res.json({success: false, msg: error})
//             });
//             scheduledJob.stop(); // Stop the cron job after running it once
//         }, {
//             scheduled: true,
//             timezone: 'UTC', // Adjust the timezone if needed
//         });
//     },
// }

// module.exports = functions