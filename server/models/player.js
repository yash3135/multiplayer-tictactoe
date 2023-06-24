const mongoose = require('mongoose');

const playerSchema = new mongoose.Schema({
    nickname: {
        type: String,
        trim: true,
    },
    socketId: {
        type: String,
    },
    points: {
        type: Number,
        default: 0,
    },
    playerType: {
        required: true,
        type: String,
    },
    isReadyToPlay : {
        default : false,
        required: true,
        type: Boolean,
    }
});

module.exports = playerSchema;