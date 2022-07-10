const jwt = require("jwt-simple");
const config = require("../config/config");

const authentication = {
	isAuthenticated: (headers) => {
		if (
			headers.authorization &&
			headers.authorization.split(" ")[0] === "Bearer"
		)
			return true;
		return false;
	},

	encodeToken: (id, cb) => {
		return cb(jwt.encode({ _id: id }, config.secret));
	},

	decodeToken: (headers, cb) => {
		if (authentication.isAuthenticated(headers)) {
			var token = headers.authorization.split(" ")[1];
			return cb(null, jwt.decode(token, config.secret));
		}
		return cb({ message: "Unable to find token." });
	},
};

module.exports = authentication;
