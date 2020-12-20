import 'dart:io';
import 'package:dio/dio.dart';

import './shared_prefs.dart';
import './response.dart';

class AuthService {
  AuthService._();

  static signup(username,password,{File image}) async{
    FormData data = FormData.fromMap({
      'username': username,
      'password': password,
      'image': await MultipartFile.fromFile(image.path,filename: image.path.split('/').last)
    });
    return HttpServer().post(
      '/signup', 
      data: data
    );
  }

  static login(username,password) async {
    return HttpServer().post(
      '/login', 
      data: {'username': username, 'password': password}
    ); 
  }

  static getCurrentUser(String id) async{
    return HttpServer().get(
      '/$id'
    );
  }

  static logout() async{
    return await SharedPrefs.removeAuthState();
  }
}