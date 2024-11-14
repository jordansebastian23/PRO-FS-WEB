import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TramiteService {
  static const String baseUrl = 'http://192.168.1.90:8000';

  /// Method to create a new Tramite
  static Future<Map<String, dynamic>> createTramite({
    required String tipo_tramite,
    required String usuarioDestino,
    required int cargaId,
    required List<int> fileTypeIds,
  }) async {
    final url = Uri.parse('$baseUrl/create_tramite/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: jsonEncode({
        'tipo_tramite': tipo_tramite,
        'usuario_destino': usuarioDestino,
        'carga_id': cargaId,
        'file_type_ids': fileTypeIds,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create tramite: ${response.body}');
    }
  }

  /// Method to check the status of an existing Tramite
  static Future<Map<String, dynamic>> checkTramite({
    required String token,
    required int tramiteId,
  }) async {
    final url = Uri.parse('$baseUrl/check_tramite/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: jsonEncode({
        'id_tramite': tramiteId,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch tramite status: ${response.body}');
    }
  }

  /// Method to mark a Tramite as successful after all files are approved
  static Future<Map<String, dynamic>> markTramiteSuccessful({
    required int tramiteId,
    required String fechaTermino,
  }) async {
    final url = Uri.parse('$baseUrl/tramite_exitoso/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: jsonEncode({
        'id_tramite': tramiteId,
        'fecha_termino': fechaTermino,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to mark tramite as successful: ${response.body}');
    }
  }

  // Method to fetch all Tramites
  static Future<List<dynamic>> fetchTramites() async {
    final url = Uri.parse('$baseUrl/list_tramites/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.get(
      url,
      headers: {
        'X-Auth-Token': token,
      }
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['tramites'] as List<dynamic>;
    } else {
      throw Exception('Failed to load tramites: ${response.body}');
    }
  }

  // get tramite files
  static Future<List<dynamic>> fetchRequiredFiles(int tramiteId) async {
    final url = Uri.parse('$baseUrl/check_tramite_files/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: jsonEncode({
        'id_tramite': tramiteId,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['required_files'] as List<dynamic>;
    } else {
      throw Exception('Failed to fetch tramite files: ${response.body}');
    }
  }

  static Future<void> approveFile(int archivoId) async {
    final url = Uri.parse('$baseUrl/approve_archivo/$archivoId/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {'X-Auth-Token': token},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to approve file: ${response.body}');
    }
  }

  static Future<void> rejectFile(int archivoId, String feedback) async {
    final url = Uri.parse('$baseUrl/reject_archivo/$archivoId/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: jsonEncode({'feedback': feedback}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reject file: ${response.body}');
    }
  }

}
