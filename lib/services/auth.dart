import './shared_prefs.dart';
import './response.dart';

class AuthService {
  AuthService._();

  static signup(username,password) async{
    return HttpServer().post(
      '/signup', 
      data: {'username': username, 'password': password}
    );
  }

  static login(username,password) async {
    return HttpServer().post(
      '/login', 
      data: {'username': username, 'password': password}
    ); 
  }

  static getCurrentUser(String id) async{
    return HttpServer().get(
      '/$id'
    );
  }

  static logout() async{
    return await SharedPrefs.removeAuthState();
  }
}