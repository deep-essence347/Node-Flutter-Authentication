import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';

class CookieManager {
  static final _cj = CookieJar();
  static const String _domain = 'http://192.168.31.68:3000';

  static List<Cookie> _cookies = [];

  static checkState() async {
    var results = await _cj.loadForRequest(Uri.parse(_domain));
    print(_cookies.length);
    assert(results.length == 1 || results.length == 0);
    if (results.length == 1) return true;
    return false;
  }

  static saveCookie(String token) async {
    _cookies.add(Cookie('token', token));
    print(_cookies.length);
    await _cj.saveFromResponse(Uri.parse(_domain), _cookies);
  }

  static loadCookie() async {
    var results = await _cj.loadForRequest(Uri.parse(_domain));
    assert(results.length == 1 || results.length == 0);
    print(_cookies.length);
    return results.first;
  }

  static removeCookie() async {
    var results = await _cj.loadForRequest(Uri.parse(_domain));
    assert(results.isEmpty);
  }
}
