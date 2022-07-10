import 'package:node_flutter/services/jwt/cookie.dart';
import 'package:node_flutter/services/jwt/response.dart';

class JwtAuth {
  JwtAuth._();

  static jwtLogin(data) => JwtResponse().post('/j/login', data: data);

  static jwtSignup(data) => JwtResponse().post('/j/signup', data: data);

  static jwtGetCurrentUser() => JwtResponse().get('/j/getInfo');

  static jwtLogout() => CookieManager.removeCookie();
}
