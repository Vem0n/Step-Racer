const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
    email: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    profilePicture: {
        type: String,
        default: ''
    },
    winStreak: {
        type: Number,
        default: 0
    },
    competitions: [{
        type: Schema.Types.ObjectId,
        ref: 'Competition'
    }],
    groupCompetitions: [{
        type: Schema.Types.ObjectId,
        ref: 'GroupCompetition'
    }]
});

module.exports = mongoose.model('User', userSchema)