var mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const userSchema = new mongoose.Schema({
	username: String,
	password: String,
	profile: String,
	profileId: String,
	items: Array,
});

userSchema.pre("save", function (next) {
	var user = this;
	if (this.isModified("password") || this.isNew) {
		bcrypt.genSalt(10, function (err, salt) {
			if (err) return next(err);
			bcrypt.hash(user.password, salt, function (err, hash) {
				if (err) return next(err);
				user.password = hash;
				next();
			});
		});
	} else return next();
});

userSchema.methods.comparePassword = function (pswd, cb) {
	bcrypt.compare(pswd, this.password, function (err, isMatch) {
		if (err) return cb(err);
		return cb(null, isMatch);
	});
};
module.exports = new mongoose.model("User", userSchema);
