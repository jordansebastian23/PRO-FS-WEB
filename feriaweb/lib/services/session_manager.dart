import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static bool _isAuthenticated = false;
  
  static Future<void> initializeAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getString('token') != null;
  }

  static bool getAuthStatusSync() {
    return _isAuthenticated;
  }
  
  static Future<void> setLoginType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('loginType', type);
  }

  static Future<String?> getLoginType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginType');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loginType');
    prefs.remove('token');
    print('El usuario se ha deslogueado');
    _isAuthenticated = false;
  }

  static Future<void> login(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    _isAuthenticated = true; // Update auth status
  }
}
