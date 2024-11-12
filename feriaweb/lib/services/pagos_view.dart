import 'dart:convert';
import 'package:http/http.dart' as http;

class PagosService {
  static const String baseUrl = 'http://192.168.1.90:8000';
  static Future<Map<String, dynamic>> fetchPagos() async {
    final url = Uri.parse('$baseUrl/list_pagos/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
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
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
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