var JwtStrategy = require("passport-jwt").Strategy;
var ExtractJwt = require("passport-jwt").ExtractJwt;

var User = require("../model/user");
var config = require("./config");

module.exports = function (passport) {
	var opts = {};

	opts.secretOrKey = config.secret;
	opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme("jwt");

	passport.use(
		new JwtStrategy(opts, function (payload, done) {
			User.find({ id: payload.id }, function (err, user) {
				if (err) return done(err, false);
				if (user) return done(null, user);
				else return done(null, false);
			});
		})
	);
};
