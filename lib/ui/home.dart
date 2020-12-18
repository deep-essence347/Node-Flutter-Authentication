import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../services/shared_prefs.dart';
import '../ui/login.dart';

class HomePage extends StatefulWidget {
  static const id = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentUser;
  @override
  void initState() {
    super.initState();
    getUserData().then((value) {
      setState(() {
        currentUser = value['user'];
      });
    });
  }

  getUserData() async{
    var user = await SharedPrefs.readAuthState();
    return await AuthService.getCurrentUser(user['userId']);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text('HomePage'),
      ),
      child: Center(
        child: currentUser != null 
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome ${currentUser['username']}'),
              FlatButton(
                child: Text('Logout'),
                color: Colors.grey,
                onPressed: () async{
                  await AuthService.logout().whenComplete((){
                    Navigator.pushNamed(context, LoginForm.id);
                  });
                },
              )
            ]
          ) : CircularProgressIndicator(backgroundColor: Colors.grey,)
      )
    );
  }
}