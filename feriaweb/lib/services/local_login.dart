import 'dart:convert';
import 'package:feriaweb/services/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    final url = Uri.parse('http://18.191.50.120/login_user/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final tempToken = responseData['token'];

      if (tempToken == null) {
        onError("Login failed: Token not found in response.");
        return {};
      }

      // Fetch user data to check if they have the "Visado" role
      final userData = await getUserData(tempToken);
      if (userData['roles'] != null && userData['roles'].contains('Visado')) {
        // Save the token only if the user has the required role
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', tempToken);
        prefs.setString('loginType', 'credentials');
        await SessionManager.login(tempToken);
        
        onSuccess();
      } else {
        onError('User does not have the required "Visado" role.');
      }
    } else {
      onError("Invalid email or password.");
    }
    return {};
  }
    

  static Future<Map<String, dynamic>> getUserData(String token) async {
    final url = Uri.parse('http://18.191.50.120/get_user_details/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
  static Future<void> logoutCredentialsUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    // Call the API to logout and invalidate the token
    // Change the IP address to the server's IP
    final url = Uri.parse('http://18.191.50.120/logout_user/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,  // Pass the token to invalidate
      },
    );

    if (response.statusCode == 200) {
      // Remove the token and session data on successful logout
      await prefs.remove('token');
      await prefs.remove('loginType');
      print("User logged out successfully.");
    } else {
      print("Failed to logout: ${response.statusCode} ${response.body}");
    }
  }
}