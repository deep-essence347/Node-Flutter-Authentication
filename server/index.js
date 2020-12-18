require('dotenv').config();
const express = require('express');
var mongoose = require("mongoose");
const bodyParser = require('body-parser');

const User = require('./model/user');

const app = express();
app.use(bodyParser.urlencoded({extended: true}));

var indexRoutes = require('./routes/index');

mongoose.set("useNewUrlParser", true);
mongoose.set("useUnifiedTopology", true);
mongoose.connect("mongodb://localhost/flude");

app.use("/",indexRoutes);

app.listen(3000, function(){
    console.log('Server started.');
});