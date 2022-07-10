import 'package:flutter/material.dart';
import 'package:node_flutter/first.dart';
import 'package:node_flutter/ui/jwt/home.dart';

import 'ui/jwt/login.dart';
import 'ui/jwt/signup.dart';
import 'ui/other/data.dart';
import 'ui/other/form.dart';
import 'ui/sharedPrefs/home.dart';
import 'ui/sharedPrefs/login.dart';
import 'ui/sharedPrefs/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstPage(),
      routes: {
        LoginForm.id: (_) => LoginForm(),
        SignupForm.id: (_) => SignupForm(),
        HomePage.id: (_) => HomePage(),
        JwtLogin.id: (_) => JwtLogin(),
        JwtSignUp.id: (_) => JwtSignUp(),
        JwtHomePage.id: (_) => JwtHomePage(),
        ItemForm.id: (_) => ItemForm(),
        Datalist.id: (_) => Datalist(),
      },
    );
  }
}
