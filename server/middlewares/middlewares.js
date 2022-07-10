const User = require("../model/user");
const authentication = require("../methods/authentication");

const middleware = {
	isLoggedIn: function (req, res, next) {
		if (authentication.isAuthenticated(req.headers)) return next();
		return res.json({
			message: "Please login to continue",
			isSuccess: false,
		});
	},

	getCurrentUser: function (req, res, next) {
		authentication.decodeToken(req.headers, function (err, decodedToken) {
			if (err)
				return res.json({
					message: err.message,
					isSuccess: false,
				});
			User.findOne({ _id: decodedToken._id }, function (err, user) {
				if (err)
					return res.json({
						message: "Unable to find your account. Please login again.",
						isSuccess: false,
					});
				else {
					req.user = user;
					return next();
				}
			});
		});
	},
};

module.exports = middleware;
