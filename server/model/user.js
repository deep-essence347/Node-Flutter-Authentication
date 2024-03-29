var mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    username: String,
    password: String,
    profile: String,
    profileId: String,
    items: Array,
});

module.exports = new mongoose.model('User', userSchema);
