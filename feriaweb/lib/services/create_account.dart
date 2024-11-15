import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAccountService{
  static Future<Map<String, dynamic>> createUser({
    required String email,
    required String displayName,
    required String phoneNumber,
    required String password,
    required String role,
  }) async{
    // Poner la ip del servidor final aqui
    final url = Uri.parse('http://18.191.50.120/create_user/');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'display_name': displayName,
        'phone_number': phoneNumber,
        'password': password,
        'role': role,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user: ${response.body}');
    }
  }
}