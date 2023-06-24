const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const friendshipSchema = new mongoose.Schema({
    user1: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    user1email: {
      type: String,
      required: true,
    },
    user2: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    user2email: {
      type: String,
      required: true
    },
    status: {
      type: String,
      default: "pending",
    }
  });
  
  
module.exports = mongoose.model("Friendship", friendshipSchema);