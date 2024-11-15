import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CargasService {
  static const String baseUrl = 'http://18.191.50.120';
  static Future<List<dynamic>> fetchCargas() async {
    final url = Uri.parse('$baseUrl/list_cargas/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['cargas'] as List<dynamic>;
    } else {
      throw Exception('Failed to load cargas: ${response.body}');
    }
  }
  static Future<Map<String, dynamic>> createCarga({
    required String email,
    required String descripcion,
    required String localizacion,
    required int pagoid,
    String? fechaRetiro,
  }) async {
    final url = Uri.parse('$baseUrl/create_carga/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: jsonEncode({
        'email': email,
        'descripcion': descripcion,
        'localizacion': localizacion,
        'id_pago': pagoid,
        if (fechaRetiro != null) 'fecha_retiro': fechaRetiro,
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