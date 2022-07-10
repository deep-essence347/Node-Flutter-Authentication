import 'package:flutter/material.dart';

import '../../services/sp/shared_prefs.dart';
import 'home.dart';
import 'login.dart';

class SharedPrefInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPrefs.checkAuth(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return CircularProgressIndicator();
        } else {
          if (!snap.data) {
            return LoginForm();
          } else {
            return HomePage();
          }
        }
      },
    );
  }
}
