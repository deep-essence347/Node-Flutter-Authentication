var mongoose = require("mongoose");
var passportLocalMongoose = require("passport-local-mongoose");

const userSchema = new mongoose.Schema({
    username: String,
    password: String,
});
userSchema.plugin(passportLocalMongoose);

module.exports = new mongoose.model('User', userSchema);
