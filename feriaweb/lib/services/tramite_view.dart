import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TramiteService {
  static const String baseUrl = 'http://192.168.1.90:8000';

  /// Method to create a new Tramite
  static Future<Map<String, dynamic>> createTramite({
    required String token,
    required String titulo,
    required String descripcion,
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
        'titulo': titulo,
        'descripcion': descripcion,
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
    required String token,
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
}
