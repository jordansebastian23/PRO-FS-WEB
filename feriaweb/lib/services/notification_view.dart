import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static const String baseUrl = 'http://192.168.1.90:8000';

  /// Method to create a new notification
  static Future<Map<String, dynamic>> createNotification({
    required String titulo,
    required String mensaje,
    required List<String> destinos,
    required String token,  // Pass the token as a parameter
  }) async {
    final url = Uri.parse('$baseUrl/create_notification/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,  // Include the token in headers
      },
      body: jsonEncode({
        'titulo': titulo,
        'mensaje': mensaje,
        'destinos': destinos,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create notification: ${response.body}');
    }
  }
}