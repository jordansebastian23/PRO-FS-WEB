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
    final url = Uri.parse('http://192.168.1.90:8000/login_user/');

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
      // Save the session cookie
      final responseData = jsonDecode(response.body);
      
      // Debug print to verify response fields
      print("Login response data: $responseData");

      // Store the token for authenticated requests
      final prefs = await SharedPreferences.getInstance();
      if (responseData['token'] != null) {
        prefs.setString('token', responseData['token']);
        prefs.setString('loginType', 'credentials');
        await SessionManager.login(responseData['token']); // Ensure authenticated status is updated
      } else {
        onError("Login failed: Token not found in response.");
        return {};
      }
      // Fetch user data to check the role
      final userData = await getUserData();
      print(userData);  
      if (userData['roles'] != null && userData['roles'].contains('Visado')) {
        onSuccess();
      } else {
        onError('User does not have the required "Visado" role.');
      }

      } else {
      onError("Invalid email or password.");
    }

    return {};
    
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final url = Uri.parse('http://192.168.1.90:8000/get_user_details/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isEmpty) {
      throw Exception("Token not found in SharedPreferences.");
    }

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,  // Use custom header
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Failed to fetch user data: ${response.statusCode} ${response.body}");
      throw Exception('Failed to fetch user data');
    }
  }
  static Future<void> logoutCredentialsUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    // Call the API to logout and invalidate the token
    // Change the IP address to the server's IP
    final url = Uri.parse('http://192.168.1.90:8000/logout_user/');
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