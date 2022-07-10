import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_flutter/services/jwt/auth.dart';
import 'package:node_flutter/services/jwt/cookie.dart';
import 'package:node_flutter/services/message.dart';

import './signup.dart';
import 'home.dart';

class JwtLogin extends StatefulWidget {
  static const id = 'JwtLogin';
  @override
  _JwtLoginState createState() => _JwtLoginState();
}

class _JwtLoginState extends State<JwtLogin> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String token;
  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text('Jwt Login'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                placeholder: "Username",
                keyboardType: TextInputType.text,
                clearButtonMode: OverlayVisibilityMode.editing,
                autocorrect: false,
                controller: _username,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                placeholder: 'Password',
                clearButtonMode: OverlayVisibilityMode.editing,
                obscureText: true,
                autocorrect: false,
                controller: _password,
              ),
            ),
            Center(
              child: FlatButton(
                child: Text('Login'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  var user = {
                    'username': _username.text,
                    'password': _password.text,
                  };

                  await JwtAuth.jwtLogin(user).then((res) async {
                    if (res['isSuccess']) {
                      await CookieManager.saveCookie(res['token']).then((_) {
                        Navigator.pushNamed(context, JwtHomePage.id);
                        FlashMessage.successFlash('Successfully logged in.');
                      });
                    } else {
                      FlashMessage.errorFlash(res['message']);
                    }
                  });
                },
              ),
            ),
            Center(
                child: Column(children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid),
              ),
              FlatButton(
                  child: Text('Sign Up'),
                  color: Colors.grey.shade300,
                  onPressed: () {
                    Navigator.pushNamed(context, JwtSignUp.id);
                  })
            ]))
          ],
        ),
      ),
    );
  }
}
