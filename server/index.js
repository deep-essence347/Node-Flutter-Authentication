require('dotenv').config();
const express = require('express');
const mongoose = require("mongoose");
const bodyParser = require('body-parser');
const cloudinary = require('cloudinary').v2;

const User = require('./model/user');

const app = express();
app.use(bodyParser.urlencoded({extended: true}),bodyParser.json({extended: true}));

var indexRoutes = require('./routes/index');
var userRoutes = require('./routes/user');

cloudinary.config({ 
    cloud_name: 'deepessence', 
    api_key: process.env.CLOUDINARY_API_KEY, 
    api_secret: process.env.CLOUDINARY_API_SECRET 
});

mongoose.set("useNewUrlParser", true);
mongoose.set("useUnifiedTopology", true);
mongoose.connect("mongodb://localhost/flude");

app.use("/",indexRoutes);
app.use('/user',userRoutes);

app.request('*',function(req,res){
    return res.json({
        message: 'Invalid Route.',
        isSuccess: false
    });
});

app.listen(3000, function(){
    console.log('Server started.');
});