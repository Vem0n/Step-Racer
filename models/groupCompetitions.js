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
        enum: ["pending", "active", "completed"],
        default: "pending",
      },
      winner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        default: null,
      },
      dateStarted: {
        type: String,
        required: true,
        default: null,
      },
      dateEnded: {
        type: String,
        default: null,
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