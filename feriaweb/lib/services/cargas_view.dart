import 'dart:convert';
import 'package:http/http.dart' as http;

class CargasService {
  static const String baseUrl = 'http://192.168.1.90:8000';
  static Future<Map<String, dynamic>> fetchCargas() async {
    final url = Uri.parse('$baseUrl/list_cargas/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cargas: ${response.body}');
    }
  }
  static Future<Map<String, dynamic>> createCarga({
    required String email,
    required String descripcion,
    required String localizacion,
    required int pagoid
  }) async {
    final url = Uri.parse('$baseUrl/create_carga/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'descripcion': descripcion,
        'localizacion': localizacion,
        'id_pago': pagoid,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create carga: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> editCarga({
    required int cargaId,
    required String descripcion,
    required String localizacion,
    required int pagoid,
  }) async {
    final url = Uri.parse('$baseUrl/edit_carga/');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'descripcion': descripcion,
        'localizacion': localizacion,
        'id_pago': pagoid,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to edit carga: ${response.body}');
    }
  }

}