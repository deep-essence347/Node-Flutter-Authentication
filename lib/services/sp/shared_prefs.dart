import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  static checkAuth() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(!_prefs.containsKey('isAuthenticated')){
      _prefs.setBool('isAuthenticated', false);
      return false;
    } else{
      if(_prefs.getBool('isAuthenticated')){
        return true;
      } else{
        return false;
      }
    }
  }
  
  static setAuthState(String id) async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('userId', id);
    _prefs.setBool('isAuthenticated', true);
    return;
  }

  static readAuthState() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var authState = {
      'userId': _prefs.getString('userId'),
      'isAuthenticated': _prefs.getBool('isAuthenticated')
    };
    return authState;
  }

  static removeAuthState() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('userId');
    _prefs.remove('isAuthenticated');
    return;
  }
}