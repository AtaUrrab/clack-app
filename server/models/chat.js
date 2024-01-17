const mongoose = require("mongoose");

const chatSchema = mongoose.Schema(
  {
    chatName: {
      type: String,
      trim: true,
    },
    isGrouChat: {
      type: Boolean,
      default: false,
    },
    users: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Users",
      },
    ],
    latestMessage: {
      type: String,
      ref: "Message",
    },
  },
  { timestamps: true }
);

const Chat = mongoose.model("ChatModel", chatSchema);
module.exports = Chat;
