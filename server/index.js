require("dotenv").config();
const express = require("express");
const passport = require("passport");
const connectDB = require("./config/db");
const cloudinary = require("./config/cloudinary");

connectDB();

const app = express();
app.use(
	express.urlencoded({ extended: true }),
	express.json({ extended: true })
);
//@desc: Passport
app.use(passport.initialize());
require("./config/passport")(passport);

cloudinary.connectCloudinary();

var indexRoutes = require("./routes/index");
var userRoutes = require("./routes/user");
var jwtRoutes = require("./routes/jwtAuth");

app.use("/", indexRoutes);
app.use("/j", jwtRoutes);
app.use("/user", userRoutes);

app.get("*", function (_, res) {
	return res.json({
		message: "Invalid Route.",
		isSuccess: false,
	});
});

app.listen(3000, function () {
	console.log("Server started.");
});
