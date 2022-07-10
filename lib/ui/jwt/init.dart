import 'package:flutter/material.dart';
import 'package:node_flutter/services/jwt/cookie.dart';
import 'package:node_flutter/ui/jwt/home.dart';
import 'package:node_flutter/ui/jwt/login.dart';

class JwtInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CookieManager.checkState(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return CircularProgressIndicator();
        } else {
          if (!snap.data) {
            return JwtLogin();
          } else {
            return JwtHomePage();
          }
        }
      },
    );
  }
}
