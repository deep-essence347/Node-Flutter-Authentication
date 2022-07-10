import 'package:flutter/material.dart';
import 'package:node_flutter/ui/jwt/login.dart';

import 'ui/sharedPrefs/login.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your method',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, LoginForm.id),
              child: Text('Shared Preferences'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, JwtLogin.id),
              child: Text('JWT'),
            ),
          ],
        ),
      ),
    );
  }
}
