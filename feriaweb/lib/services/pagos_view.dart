import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PagosService {
  static const String baseUrl = 'http://18.191.50.120';
  static Future<List<dynamic>> fetchPagos() async {
    final url = Uri.parse('$baseUrl/list_pagos/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['pagos'] as List<dynamic>;
    } else {
      throw Exception('Failed to load pagos: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> pago_Exitoso() async {
    final url = Uri.parse('$baseUrl/pago_exitoso/');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to approve pago: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> createPago({
    required String email,
    required int monto,
  }) async {
    final url = Uri.parse('$baseUrl/create_pago/');
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
        'monto': monto,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create pago: ${response.body}');
    }
  }
  
}