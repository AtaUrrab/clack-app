const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const nodemailer = require("nodemailer");
const jwtSecret = process.env.JWT_SECRET || "defaultSecret";
const OTP_EXPIRY_TIME = 5 * 60 * 1000; // 5 minutes in milliseconds
const otpStore = {};
const otpStoreTimestamp = {};

// Signup Route
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({ msg: "Same email already exists!" });
    }

    const hashedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
    });
    user = await user.save();
    res.json({ success: true, user });
    return;
  } catch (e) {
    res
      .status(500)
      .json({ error: "An unexpected error occurred during signup." });
  }
});

// Signin Route
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ msg: "This Email does not exist!" });
    }
    const isMatched = await bcrypt.compare(password, user.password);
    if (!isMatched) {
      return res.status(400).json({ msg: "Incorrect password" });
    }
    const token = jwt.sign({ id: user._id }, jwtSecret);
    res.json({ success: true, token, ...user._doc });
    return;
  } catch (e) {
    res
      .status(500)
      .json({ error: "An unexpected error occurred during signin." });
  }
});

// For checking if a token is valid
authRouter.post("/isTokenValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.json(false);
    }
    const isVerified = jwt.verify(token, jwtSecret);
    if (!isVerified) {
      return res.json(false);
    }
    const user = await User.findById(isVerified.id);
    if (!user) {
      return res.json(false);
    }
    return res.json(true);
  } catch (e) {
    res.status(500).json({ error: "An unexpected error occurred" });
  }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

// Logout Route
authRouter.post("/api/logout", auth, async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    res.json({ success: true, msg: "Successfully logged out" });
  } catch (e) {
    res
      .status(500)
      .json({ error: "An unexpected error occurred during logout." });
  }
});

// Route to request OTP
authRouter.post("/api/requestOTP", async (req, res) => {
  try {
    const { email, password } = req.body;

    // Generate a random 4-digit OTP
    const otp = Math.floor(1000 + Math.random() * 9000);

    // Save the OTP in the in-memory store with a timestamp
    otpStore[email] = {
      otp,
      timestamp: Date.now(),
    };

    // Send OTP to user's email using nodemailer
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "sapphiredevelopers1@gmail.com", // replace with your Gmail address
        pass: "ryij gchk etij gvfm", // replace with the App Password you generated
      },
    });

    const mailOptions = {
      from: "clackapp@gmail.com",
      to: email,
      subject: "OTP Verification",
      text: `Your OTP for account verification is: ${otp}`,
    };

    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        res.status(500).json({ error: "Error sending OTP email." });
      } else {
        res.json({ success: true, otp });
      }
    });
  } catch (e) {
    res
      .status(500)
      .json({ error: "An unexpected error occurred during OTP request." });
  }
});

// Route to resend OTP
authRouter.post("/api/resendOTP", async (req, res) => {
  try {
    const { email } = req.body;

    // Check if the email is present in the request body
    if (!email) {
      return res
        .status(400)
        .json({ error: "Email is missing in the request body." });
    }

    console.log("Request Body:", req.body);
    console.log(`Email: ${email}`);
    console.log(`OTP in otpStore: ${otpStore[email]}`);

    // Check if the email exists in the in-memory store
    if (otpStore[email] !== undefined) {
      // Generate a new random 4-digit OTP
      const newOtp = Math.floor(1000 + Math.random() * 9000);

      // Update the OTP in the in-memory store
      otpStore[email] = newOtp;

      // Send the new OTP to the user's email using nodemailer
      const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: "sapphiredevelopers1@gmail.com",
          pass: "ryij gchk etij gvfm",
        },
      });

      const mailOptions = {
        from: "clackapp@gmail.com",
        to: email,
        subject: "Resend OTP",
        text: `Your new OTP for account verification is: ${newOtp}`,
      };

      transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
          console.error("Error sending email:", error);
          res.status(500).json({ error: "Error sending OTP email." });
        } else {
          console.log("Email sent:", info.response);
          res.json({ success: true, newOtp });
        }
      });
    } else {
      res.status(400).json({ error: "Email not found. Cannot resend OTP." });
    }
  } catch (e) {
    console.log("Error resending OTP:", e);
    res
      .status(500)
      .json({ error: "An unexpected error occurred during OTP resend." });
  }
});

// Route to verify OTP
authRouter.post("/api/verifyOTP", async (req, res) => {
  try {
    const { email, otp } = req.body;

    // Check if email and otp are present in the request body
    if (!email || !otp) {
      return res.status(400).json({ error: "Email and OTP are required." });
    }

    // Retrieve the stored OTP and timestamp for the given email
    const storedOTP = otpStore[email];
    const otpTimestamp = otpStoreTimestamp[email];

    // Check if the stored OTP and timestamp exist and are not null or undefined
    if (
      storedOTP !== undefined &&
      otpTimestamp !== undefined &&
      otpTimestamp !== null
    ) {
      // Check if the OTP is expired
      const currentTime = Date.now();
      if (currentTime - otpTimestamp < OTP_EXPIRY_TIME) {
        // Check if the received OTP matches the stored OTP
        if (otp === storedOTP) {
          // Clear the OTP and timestamp from the store after successful verification
          delete otpStore[email];
          delete otpStoreTimestamp[email];

          res.json({ success: true });
        } else {
          res.status(400).json({ error: "Invalid OTP" });
        }
      } else {
        res.status(400).json({ error: "OTP expired" });
      }
    } else {
      res.status(400).json({ error: "Invalid email or OTP" });
    }
  } catch (e) {
    console.error("Error verifying OTP:", e);
    res.status(500).json({
      error: `An unexpected error occurred during OTP verification. ${e.message}`,
    });
  }
});

module.exports = authRouter;
