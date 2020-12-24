const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const multer = require("multer");
const cloudinary = require("cloudinary").v2;
const User = require("../model/user");

const saltRounds = 10;
var storage = multer.diskStorage({
  filename: function (req, file, callback) {
    callback(null, Date.now() + file.originalname);
  },
});
var upload = multer({ storage: storage });

router.get("/", function (req, res) {
  return res.send("You are not authorized to visit this website.");
});

router.post("/signup", upload.single("image"), function (req, res) {
  User.findOne({ username: req.body.username }, function (err, foundUser) {
    if (err) {
      return res.json({
        message: err.message,
        isSuccess: false,
      });
    } else {
      if (!foundUser) {
        bcrypt.hash(req.body.password, saltRounds, function (err, hash) {
            if(err){
                return res.json({
                    message: err.message,
                    isSuccess: false,
                });
            } else{
                const newUser = new User();
                newUser.username = req.body.username;
                newUser.password = hash;
                cloudinary.uploader.upload(req.file.path, {folder: 'profile/',public_id: newUser._id},function (err, result) {
                    if (err) {
                    res.json({
                        message: err.message,
                        isSuccess: false,
                    });
                    } else {
                        newUser.profile = result.secure_url;
                        newUser.profileId = result.public_id;
                        newUser.save(function (err) {
                            if (!err) {
                                return res.json({
                                    message: "User has been registered.",
                                    userId: newUser._id,
                                    isSuccess: true,
                                });
                            } else {
                                return res.json({
                                    message: err.message,
                                    isSuccess: false,
                                });
                            }
                        });
                    }
                });
            }
        });
      } else {
        return res.json({
          message: "Username already exists.",
          isSuccess: false,
        });
      }
    }
  });
});

router.post("/login", function (req, res) {
  User.findOne({ username: req.body.username }, function (err, foundUser) {
    if (err) {
      return res.json({
        message: err.message,
        isSuccess: false,
      });
    } else {
      if (!foundUser) {
        return res.json({
          message: "Invalid Username/Password.",
          isSuccess: false,
        });
      } else {
        bcrypt.compare(
          req.body.password,
          foundUser.password,
          function (err, result) {
            if (result) {
              return res.json({
                message: "User found",
                userId: foundUser._id,
                isSuccess: true,
              });
            } else {
              return res.json({
                message: "Invalid Username/Password.",
                isSuccess: false,
              });
            }
          }
        );
      }
    }
  });
});

module.exports = router;
