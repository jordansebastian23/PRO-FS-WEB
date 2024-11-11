import 'dart:convert';
import 'package:http/http.dart' as http;

class FilesView {
  static Future<Map<String, dynamic>> fetchFiles() async {
    final url = Uri.parse('http://192.168.1.90/list_files/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load files: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> approveFile(int archivoId) async {
    final url = Uri.parse('http://192.168.1.90/approve_archivo/$archivoId/');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to approve file: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> rejectFile(int archivoId, String feedback) async {
    final url = Uri.parse('http://192.168.1.90/reject_archivo/$archivoId/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'feedback': feedback,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reject file: ${response.body}');
    }
  }
  
}