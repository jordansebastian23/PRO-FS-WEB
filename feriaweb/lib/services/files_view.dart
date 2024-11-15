import 'dart:convert';
import 'package:http/http.dart' as http;

class FilesView {
  static const String baseUrl = 'http://18.191.50.120';
  static Future<List<dynamic>> fetchFiles() async {
    final url = Uri.parse('$baseUrl/list_files/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['files'] as List<dynamic>;
    } else {
      throw Exception('Failed to load files: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> approveFile(int archivoId) async {
    final url = Uri.parse('http://18.191.50.120/approve_archivo/$archivoId/');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to approve file: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> rejectFile(int archivoId, String feedback) async {
    final url = Uri.parse('http://18.191.50.120/reject_archivo/$archivoId/');
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

  static Future<int> fetchFilesCount() async {
    final url = Uri.parse('$baseUrl/list_files/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final files = responseBody['files'] as List<dynamic>;
      return files.length;
    } else {
      throw Exception('Failed to load files: ${response.body}');
    }
  }
  
}