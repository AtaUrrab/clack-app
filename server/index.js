// Import from packages section
const express = require("express");
const mongoose = require("mongoose");
// const moment = require("moment");

// import from files section
const authRouter = require("./routes/auth");

// Initialization section
const port = 3000;
const app = express();
const DB =
  "mongodb+srv://sapphiredevelopers1:sapphire01@cluster0.erwil60.mongodb.net/?retryWrites=true&w=majority";

// middlrware
app.use(express.json());
app.use(authRouter);
var clients = {};

// HTTP Server Initialization
const http = require("http").createServer(app);

// app.listen(port, "0.0.0.0", () => {
//   console.log(`Connected at port ${port}`);
// });

// const currentDate = moment();
// console.log(
//   "Current Date and Time:",
//   currentDate.format("YYYY-MM-DD HH:mm:ss")
// );

//Socket Logic
const socketio = require("socket.io")(http, {
  path: "/socket.io",
});

socketio.on("connection", (userSocket) => {
  console.log(userSocket.id, "has joined");

  userSocket.on("/test", (id) => {
    console.log("Message: ", id);
  });

  userSocket.on("send_message", (data) => {
    console.log("Received message:", data);
    // Broadcast the received message to all connected clients
    socketio.emit("receive_message", data);
  });
});

// Server Listening
const server = http.listen(port, "0.0.0.0", () => {
  console.log(`Connected at port ${port}`);
});

server.on("error", (err) => {
  console.error("Server error:", err);
});

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("MongoDB Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });
