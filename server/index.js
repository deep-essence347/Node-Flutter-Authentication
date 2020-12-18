require('dotenv').config();
const express = require('express');
var mongoose = require("mongoose");
const bodyParser = require('body-parser');
const session = require('express-session');
const passport = require('passport');
const LocalStrategy = require("passport-local");

const User = require('./model/user');

const app = express();
app.use(bodyParser.urlencoded({extended: true}));

var indexRoutes = require('./routes/index');

mongoose.set("useNewUrlParser", true);
mongoose.set("useUnifiedTopology", true);
mongoose.connect("mongodb://localhost/flude");

app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
    })
);

app.use(passport.initialize());
app.use(passport.session());

passport.use(new LocalStrategy(User.authenticate()));
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

app.use(function(req,res,next){
    res.locals.currentUser = req.user;
    next();
});

app.use("/",indexRoutes);

app.listen(3000, function(){
    console.log('Server started.');
});