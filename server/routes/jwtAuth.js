const express = require("express");
const router = express.Router();
const User = require("../model/user");
const cloudinary = require("../config/cloudinary");
const Upload = require("../methods/images");
const middleware = require("../middlewares/middlewares");
const authentication = require("../methods/authentication");

router.post("/signup", cloudinary.configStorage("image"), function (req, res) {
	if (!req.body.username || !req.body.password)
		return res.json({
			message: "Enter all fields.",
			isSuccess: false,
		});
	var newUser = User(req.body);
	Upload.upload(
		{ filePath: req.file.path, folder: "profile/", name: newUser._id },
		function (err, result) {
			if (err) {
				return res.json({
					message: "Unable to upload image.",
					isSuccess: false,
				});
			}
			newUser.profile = result.secure_url;
			newUser.profileId = result.public_id;
			newUser.save(function (err) {
				if (err) return res.json({ message: err.message, isSuccess: false });
				else
					authentication.encodeToken(newUser._id, function (token) {
						return res.json({ token: token, isSuccess: true });
					});
			});
		}
	);
});

router.post("/login", function (req, res) {
	User.findOne({ username: req.body.username }, function (err, user) {
		if (err) {
			throw err;
		}
		if (!user) {
			return res.json({ message: "User not found.", isSuccess: false });
		} else {
			user.comparePassword(req.body.password, function (err, isMatch) {
				if (isMatch && !err) {
					authentication.encodeToken(user._id, function (token) {
						return res.json({ token: token, isSuccess: true });
					});
				} else {
					return res.json({ message: "Invalid password", isSuccess: false });
				}
			});
		}
	});
});

router.get("/getInfo", middleware.getCurrentUser, function (req, res) {
	return res.json({
		user: req.user,
		isSuccess: true,
	});
});

module.exports = router;
