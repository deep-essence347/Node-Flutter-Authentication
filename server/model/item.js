var mongoose = require("mongoose");

const itemSchema = new mongoose.Schema({
    name: String,
    price: Number,
    userId: String
});

module.exports = new mongoose.model('Item', itemSchema);
