const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const groupCompetitionSchema = new Schema({
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
      owner3: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      owner4: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      owner5: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      owner6: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
      },
      status: {
        type: String,
        default: "pending",
      },
      user2AcceptedStatus: {
        type: String,
        default: "pending"
      },
      user3AcceptedStatus: {
        type: String,
        default: null
      },
      user4AcceptedStatus: {
        type: String,
        default: null
      },
      user5AcceptedStatus: {
        type: String,
        default: null
      },
      user6AcceptedStatus: {
        type: String,
        default: null
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
      tLength: {
        type: String,
        required: true
      },
      refreshIntervals: {
        type: String,
        required: true
      },
      stepsOwner1: {
        type: String,
        default: null,
      },
      stepsOwner2: {
        type: String,
        default: null,
      },
      stepsOwner3: {
        type: String,
        default: null,
      },
      stepsOwner4: {
        type: String,
        default: null,
      },
      stepsOwner5: {
        type: String,
        default: null,
      },
      stepsOwner6: {
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
      initialSteps3: {
        type: String,
        default: null
      },
      initialSteps4: {
        type: String, 
        default: null
      },
      initialSteps5: {
       type: String, 
       default: null
    },
      initialSteps6: {
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
      owner3Status: {
        type: String,
        default: null,
      },
      owner4Status: {
        type: String,
        default: null,
      },
      owner5Status: {
        type: String,
        default: null,
      },
      owner6Status: {
        type: String,
        default: null,
      },
})

module.exports = mongoose.model('GroupCompetition' ,groupCompetitionSchema);