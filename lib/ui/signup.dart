import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/message.dart';
import '../services/shared_prefs.dart';
import '../services/auth.dart';
import './login.dart';
import './home.dart';


class SignupForm extends StatefulWidget {
  static const id = 'signupForm';
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _username=TextEditingController();
  final TextEditingController _password=TextEditingController();
  
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
        middle: Text('SignUp'),
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
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: ()async{
                  await AuthService.signup(_username.text, _password.text).then((res)async{
                    if(res['isSuccess']){
                      await SharedPrefs.setAuthState(res['userId']);
                      Navigator.pushNamed(context, HomePage.id);
                      FlashMessage.successFlash(res['message']);
                    } else {
                      FlashMessage.errorFlash(res['message']);
                    }
                  });
                },
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationStyle: TextDecorationStyle.solid
                    ),
                  ),
                  FlatButton(
                    child: Text('Login'),
                    color: Colors.grey.shade300,
                    onPressed: (){
                      Navigator.pushNamed(context, LoginForm.id);
                    }
                  )
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}