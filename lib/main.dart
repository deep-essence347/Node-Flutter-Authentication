import 'package:flutter/material.dart';
import 'package:node_flutter/ui/data.dart';
import 'package:node_flutter/ui/form.dart';
import './services/shared_prefs.dart';
import './ui/home.dart';
import './ui/login.dart';
import './ui/signup.dart';

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
      home: FutureBuilder(
        future: SharedPrefs.checkAuth(),
        builder: (context, snap){
          if(!snap.hasData){
            return CircularProgressIndicator();
          } else {
            if(!snap.data){
              return LoginForm();
            } else {
              return HomePage();
            }
          }
        },
      ),
      routes: {
        LoginForm.id: (context) => LoginForm(),
        SignupForm.id: (context) => SignupForm(),
        HomePage.id: (context) => HomePage(),
        ItemForm.id: (context) => ItemForm(),
        Datalist.id: (context) => Datalist(),
      },
    );
  }
}
