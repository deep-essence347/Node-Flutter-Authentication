import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_flutter/services/jwt/auth.dart';
import 'package:node_flutter/ui/sharedPrefs/login.dart';

import '../../services/message.dart';
import '../other/data.dart';
import '../other/form.dart';

class JwtHomePage extends StatefulWidget {
  static const id = 'jwtHomePage';

  @override
  _JwtHomePageState createState() => _JwtHomePageState();
}

class _JwtHomePageState extends State<JwtHomePage> {
  var currentUser;

  @override
  void initState() {
    getUserInfo().then((res) {
      if (res['isSuccess'])
        setState(() {
          currentUser = res['user'];
        });
      else
        FlashMessage.errorFlash(res['message']);
    });
    super.initState();
  }

  getUserInfo() async {
    return await JwtAuth.jwtGetCurrentUser();
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xffffffff),
                          width: 3,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: NetworkImage(currentUser['profile']),
                      radius: 50,
                    ),
                  ),
                  Text('Welcome ${currentUser['username']}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        child: Text('Form'),
                        onPressed: () {
                          Navigator.pushNamed(context, ItemForm.id);
                        },
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 20),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Datalist.id);
                        },
                        child: Text('Data'),
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                  FlatButton(
                    child: Text('Logout'),
                    color: Colors.grey,
                    onPressed: () async {
                      // await AuthService.logout().whenComplete(() {
                      //   Navigator.pushNamed(context, LoginForm.id);
                      //   FlashMessage.successFlash(
                      //       'You have been logged out successfully');
                      // });
                      await JwtAuth.jwtLogout().then(() {
                        Navigator.pushNamed(context, LoginForm.id);
                      });
                    },
                  ),
                ],
              )
            : CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
      ),
    );
  }
}
