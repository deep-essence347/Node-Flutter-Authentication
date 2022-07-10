import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:node_flutter/services/jwt/auth.dart';
import 'package:node_flutter/services/jwt/cookie.dart';
import 'package:node_flutter/services/message.dart';

import './login.dart';

class JwtSignUp extends StatefulWidget {
  static const id = 'JwtSignUp';
  @override
  _JwtSignUpState createState() => _JwtSignUpState();
}

class _JwtSignUpState extends State<JwtSignUp> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  File _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    final File pickedImageFile = File(imageFile.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

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
        middle: Text('Jwt SignUp'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                      _pickedImage != null ? FileImage(_pickedImage) : null,
                ),
                FlatButton.icon(
                  textColor: Colors.blue.shade300,
                  onPressed: _pickImage,
                  icon: Icon(_pickedImage == null
                      ? Icons.add_photo_alternate
                      : Icons.image),
                  label:
                      Text(_pickedImage == null ? 'Add Image' : 'Change Image'),
                ),
              ],
            ),
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
                onPressed: () async {
                  FormData user = FormData.fromMap({
                    'username': _username.text,
                    'password': _password.text,
                    'image': await MultipartFile.fromFile(_pickedImage.path,
                        filename: _pickedImage.path.split('/').last)
                  });
                  print('Signing Up');
                  await JwtAuth.jwtSignup(user).then((res) {
                    if (res['isSuccess']) {
                      CookieManager.saveCookie(res['token']);
                      FlashMessage.successFlash(res['message']);
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
                'Already have an account?',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid),
              ),
              FlatButton(
                  child: Text('Login'),
                  color: Colors.grey.shade300,
                  onPressed: () {
                    Navigator.pushNamed(context, JwtLogin.id);
                  })
            ]))
          ],
        ),
      ),
    );
  }
}
