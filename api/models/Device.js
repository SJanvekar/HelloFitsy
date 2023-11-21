var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var DeviceSchema = new Schema({

    //User ID
    UserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },

    //Timestamp when the device was registered for receiving notifications
    RegisteredAt: {
        type: Date,
        required: true,
    },
})

module.exports = mongoose.model('Device', DeviceSchema)