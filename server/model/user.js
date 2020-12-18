var mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    username: String,
    password: String
});

module.exports = new mongoose.model('User', userSchema);
