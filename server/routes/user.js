const express = require("express");
const item = require("../model/item");
const router = express.Router();

const Item = require('../model/item');
const User = require('../model/user');

// Returns Current User Data
router.get("/", function (req, res) {
    User.findOne({ _id: req.query.userId }, function (err, foundUser) {
      if (!err) {
        if (foundUser) {
          return res.json({
            user: foundUser,
            message: "Found current User",
            isSuccess: true,
          });
        } else {
          return res.json({
            message: "Current User not found",
            isSuccess: false,
          });
        }
      } else {
        return res.json({
          message: "Error getting data",
          isSuccess: false,
        });
      }
    });
});

// Adds an Item to MongoDB database
router.post('/:id/addItem', function(req,res){
    User.findOne({_id: req.params.id}, function(err,foundUser){
        if(err){
            return res.json({
                message: err.message,
                isSuccess: false
            });
        } else {
            if(!foundUser){
                return res.json({
                    message: 'Current User cannot be found',
                    isSuccess: false
                });
            } else {
                const newItem = new Item({
                    name: req.body.name,
                    price: req.body.price,
                    userId: req.params.id
                });
                newItem.save(function(err){
                    if(err){
                        return res.json({
                            message: err.message,
                            isSuccess: false
                        });
                    } else {
                        foundUser.items.push(newItem._id);
                        foundUser.save(function(err){
                            return res.json({
                                message: 'Item added.',
                                isSuccess: true
                            });
                        });
                    }
                });
            }
        }
    });
});

// returns all items present in the database
router.get('/allData', function(req,res){
    Item.find({}, function(err,items){
        if(err){
            return res.json({
                message: 'Failed to get Data',
                isSuccess: false,
            });
        } else{
            if(items.length === 0){
                return res.json({
                    message: 'No data available',
                    isSuccess: true
                });
            } else {
                return res.json({
                    items: items,
                    isSuccess: true
                })
            }
        }
    })
});

// returns an item from MongoDB database
router.get('/data/:id', function(req,res){
    Item.find({_id: req.params.id}, function(err,item){
        if(err){
            return res.json({
                message: 'Failed to get Data',
                isSuccess: false,
            });
        } else{
            if(!item){
                return res.json({
                    message: 'No data available',
                    isSuccess: true
                });
            } else {
                return res.json({
                    items: item,
                    isSuccess: true
                })
            }
        }
    })
});

// Returns the items with item.name containing the queried value
router.get('/search',function(req,res){
    Item.find({name: new RegExp(req.query.query)},function(err, items){
        if(err){
            return res.json({
                message: err.message,
                isSuccess: false
            });
        } else {
          if(items.length === 0){
                return res.json({
                    message: 'No value present.',
                    isSuccess: true
                });
            } else {
                return res.json({
                    items: items,
                    isSuccess: true
                });
            }
        }
    });
});

module.exports = router;