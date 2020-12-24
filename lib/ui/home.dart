import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_flutter/ui/data.dart';
import 'package:node_flutter/ui/form.dart';
import '../services/auth.dart';
import '../services/shared_prefs.dart';
import '../ui/login.dart';
import '../services/message.dart';

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

  getUserData() async {
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
                        onPressed: (){
                          Navigator.pushNamed(context, ItemForm.id);
                        },
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 20),
                      FlatButton(
                        onPressed: (){
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
                      await AuthService.logout().whenComplete(() {
                        Navigator.pushNamed(context, LoginForm.id);
                        FlashMessage.successFlash(
                            'You have been logged out successfully');
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
