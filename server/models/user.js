const mongoose = require("mongoose");

// Schema
const userSchema = mongoose.Schema({
  //
  name: {
    require: true,
    type: String,
    trim: true,
  },

  //
  userName: {
    type: String,
    trim: true,
    unique: true,
    default: "",
  },

  //
  email: {
    require: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const res =
          /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
        return value.match(res);
      },
      message: "Pleas enter a valid email address",
    },
  },

  //
  password: {
    require: true,
    type: String,
    validate: {
      validator: (value) => {
        return value.length > 7;
      },
      message: "Password must contain 8 characters",
    },
  },

  //
  userBio: {
    type: String,
    trim: true,
    default: "",
  },

  //
  profilePicture: {
    type: String, // Assuming you store the URL or file path of the profile picture
    default: "", // You can set a default value if needed
  },

  //
  isOnline: {
    type: Boolean,
    default: false,
  },

  //
  isVerifiedAccount: {
    type: Boolean,
    default: false,
  },
});

const User = mongoose.model("UserModel", userSchema);
module.exports = User;
