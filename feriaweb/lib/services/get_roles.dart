import 'dart:convert';
import 'package:http/http.dart' as http;

class RoleService {
  static Future<List<String>> fetchRoles() async {
    // Poner la ip del servidor final aqui
    final url = Uri.parse('http://192.168.1.90:8000/list_roles/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return List<String>.from(data['roles'].map((role) => role['nombre']));
    } else {
      throw Exception('Failed to load roles: ${response.body}');
    }
  }
}