import 'package:flutter/cupertino.dart';

class ItemModel{
  ItemModel({@required this.id,@required this.name,@required this.price,@required this.userId});
  
  final String id;
  final String name;
  final int price;
  final String userId;

  ItemModel.fromJson(Map<String,dynamic> item):
      id = item['_id'],
      name = item['name'],
      price = item['price'],
      userId = item['userId'];
}