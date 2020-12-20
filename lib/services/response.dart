import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HttpServer{
  final String _domain= 'http://192.168.0.112:3000';
  Dio dio = new Dio();
  
  post(route, {@required data}) async {
    try{
      return await dio.post(
        '$_domain$route',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType)
      ).then((value) => value.data);
    } catch(err){
      return {
        'message': err.message,
        'isSuccess': false
      };
    }
  }

  get(route) async {
    try{
      return await dio.get(
        '$_domain$route',
      ).then((value) => value.data);
    } catch(err){
      return {
        'message': err.message,
        'isSuccess': false
      };
    }
  }
}

