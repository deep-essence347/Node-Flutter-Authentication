import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:node_flutter/services/jwt/cookie.dart';

class JwtResponse {
  final String _domain = 'http://192.168.31.68:3000';
  Dio dio = new Dio();

  post(route, {@required data}) async {
    print(route);
    try {
      return await dio
          .post(
            '$_domain$route',
            data: data,
            options: Options(contentType: Headers.formUrlEncodedContentType),
          )
          .then((value) => value.data);
      // } on DioError catch (err) {
      //   return {'message': err.response.data['message'], 'isSuccess': false};
    } catch (err) {
      print(err.toString());
      return {'message': err.toString(), 'isSuccess': false};
    }
  }

  get(route, {data}) async {
    var headers = {'Authorization': await authorizationToken()};
    try {
      return await dio
          .get(
            '$_domain$route',
            queryParameters: data,
            options: Options(
              headers: headers,
            ),
          )
          .then((value) => value.data);
    } catch (err) {
      return {'message': err.toString(), 'isSuccess': false};
    }
  }

  authorizationToken() async {
    Cookie cookie = await CookieManager.loadCookie();
    if (cookie != null)
      return 'Bearer ${cookie.value}';
    else
      return null;
  }
}
