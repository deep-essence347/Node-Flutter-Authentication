var express = require("express");
var router = express.Router();
const bcrypt = require('bcrypt');
const User = require('../model/user');

const saltRounds = 10;
router.get('/',function(req,res){
    return res.send('You are not authorized to visit this website.');
});

router.post('/signup', function(req,res){
    User.findOne({username: req.body.username},function(err,foundUser){
        if(err){
            return res.json({
                message: err.message,
                isSuccess: false
            })
        } else {
            if(!foundUser){
                bcrypt.hash(req.body.password,saltRounds,function(err,hash){
                    const newUser = new User({
                        username: req.body.username,
                        password: hash,
                    })
                    newUser.save(function(err){
                        if(!err){
                            return res.json({
                                message:'User has been registered.',
                                userId: newUser._id,
                                isSuccess: true
                            })
                        } else{
                            return res.json({
                                message: err.message,
                                isSuccess: false
                            })
                        }
                    })
                })
            } else{
                return res.json({
                    message: 'Username already exists.',
                    isSuccess: false
                })
            }
        }
    })
})

router.post('/login',function(req,res){
    User.findOne({username: req.body.username},function(err,foundUser){
        if(err){
            return res.json({
                message: err.message,
                isSuccess: false
            });
        } else{
            if(!foundUser){
                return res.json({
                    message: 'Invalid Username/Password.',
                    isSuccess: false
                });
            } else {
                bcrypt.compare(req.body.password, foundUser.password, function(err, result) {
                    if(result){
                        return res.json({
                            message: 'User found',
                            userId: foundUser._id,
                            isSuccess: true
                        })
                    } else {
                        return res.json({
                            message: 'Invalid Username/Password.',
                            isSuccess: false
                        })
                    }
                });
            }
        }
    })
})

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
