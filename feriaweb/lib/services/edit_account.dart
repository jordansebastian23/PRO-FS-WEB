import 'dart:convert';
import 'package:http/http.dart' as http;

class EditAccountService {
  static Future<Map<String, dynamic>> editUser({
    required String email,
    required String displayName,
    required String phoneNumber,
    required String role,
  }) async {
    final url = Uri.parse('http://18.191.50.120/edit_user/');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'display_name': displayName,
        'phone_number': phoneNumber,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit user: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> disableUser({
    required String email,
  }) async {
    final url = Uri.parse('http://18.191.50.120/disable_user/');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to disable user: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> enableUser({
    required String email,
  }) async {
    final url = Uri.parse('http://18.191.50.120/enable_user/');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to enable user: ${response.body}');
    }
  }

  static Future<List<dynamic>> getUsers() async {
    final url = Uri.parse('http://18.191.50.120/list_users/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['users'] as List<dynamic>;
    } else {
      throw Exception('Failed to get users: ${response.body}');
    }
  }
}
