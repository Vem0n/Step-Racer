const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const competitionSchema = new Schema({
    owner1: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      owner2: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      status: {
        type: String,
        default: "pending",
      },
      userAcceptedStatus: {
        type: String,
        default: 'pending'
      },
      tLength: {
        type: String,
        required: true
      },
      refreshIntervals: {
        type: String,
        required: true
      },
      winner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        default: null,
      },
      startedAt: {
        type: Date,
        default: null,
      },
      endsAt: {
        type: Date,
        default: null,
      },
      expiresAt: {
        type: Date
      },
      stepsOwner1: {
        type: String,
        default: null,
      },
      stepsOwner2: {
        type: String,
        default: null,
      },
      initialSteps1: {
        type: String,
        default: null
      },
      initialSteps2: {
        type: String,
        default: null
      },
      owner1Status: {
        type: String,
        default: null,
      },
      owner2Status: {
        type: String,
        default: null,
      },
})

module.exports = mongoose.model('Competition', competitionSchema);