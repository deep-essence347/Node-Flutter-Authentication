var express = require("express");
var router = express.Router();
const passport = require('passport');

const User = require('../model/user');

router.get('/',function(req,res){
    return res.send('Hello World.');
});

router.post('/signup',function(req,res){
    let user = new User({
        username: req.body.username,
    });
    User.findOne({username: req.body.username}, function(err, foundUser){
        if(err){
            return res.json({
                message: err.message,
                isSuccess: false
            })
        } else {
            if(!foundUser){
                User.register(user,req.body.password,function(err,user){
                    if(!err){
                        passport.authenticate('local')(req, res,function(){
                            return res.json({
                                message:'User has been registered.',
                                userId: user._id,
                                isSuccess: true
                            })
                        });
                    } else{
                        return res.json({
                            message: err.message,
                            isSuccess: false
                        })
                    }
                });
            } else{
                return res.json({
                    message: 'Username already exists.',
                    isSuccess: false
                })
            }
        }
    });
    
})

router.post('/login', function(req,res,next){
    passport.authenticate("local", function (err, user, info) {
        if (err) {
            return res.json({
                message: err.message,
                isSuccess: false
            })
        }
        if (!user) {
            return res.json({
                message: 'Invalid Username/Password.',
                isSuccess: false
            })
        }
        req.logIn(user, function (err) {
          if (err) {
              return res.json({
                message: err.message,
                isSuccess: false
              })
          } else{
            return res.json({
                message: 'User found',
                userId: user._id,
                isSuccess: true
            })
          }
        });
    })(req, res, next);
});

router.get('/:id',function(req,res){
    User.findOne({_id: req.params.id}, function(err,foundUser){
        if(!err){
            if(foundUser){
                return res.json({
                    user: foundUser,
                    message: 'Found current User',
                    isSuccess: true
                });
            } else {
                return res.json({
                    message: 'Current User not found',
                    isSuccess: false
                });
            }
        } else {
            return res.json({
                message: 'Error getting data',
                isSuccess: false
            });
        }
    });
});

module.exports = router;
