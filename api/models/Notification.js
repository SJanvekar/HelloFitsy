var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var NotificationSchema = new Schema({

    //Notification Title
    Title: {
        type: String,
        ref: 'User',
        required: true,
    },

    //Notification Body
    Body: {
        type: String,
        ref: 'User',
        required: true,
    },

    //Timestamp when the notification was sent from FCM
    SentAt: {
        type: Date,
        required: true,
    },

    //Timestamp when the notification was received by the iOS app
    ReceivedAt: {
        type: Date,
        required: true,
    },

    //Unique token associated with the iOS device that received the notification
    DeviceToken: {
        type: String,
        required: true,
    },
})

module.exports = mongoose.model('Notification', NotificationSchema)