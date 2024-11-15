import 'dart:convert';

import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/cards/custom_card_archives.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:feriaweb/services/files_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArchiveUpploadDatasource extends DataTableSource {
  late BuildContext context;
  final List<dynamic> files;

  ArchiveUpploadDatasource(this.context, this.files);

  @override
  DataRow? getRow(int index) {
    if (index >= files.length) return null;
    final file = files[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(file['id'].toString())),
        DataCell(Text(file['usuario'] ?? 'Unknown User')),
        DataCell(Text(file['nombre_archivo'] ?? 'Unknown Type')),
        DataCell(Text(file['fecha_subida'] != null 
            ? DateFormat('dd/MM/yyyy').format(DateTime.parse(file['fecha_subida'])) 
            : 'N/A')),
        DataCell(Text(file['estado_procesamiento'])),
        DataCell(TextButton(
          onPressed: () {
            _showDetailsDialog(context, file);
          },
          child: Text('Comparar', style: TextStyle(color: Colors.teal)),
        )),
      ],
    );
  }

  void _showDetailsDialog(BuildContext context, Map<String, dynamic> file) {
  String? selectedTemplate;
  bool isComparing = false; // to show loading indicator

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Detalles Archivo Número de Trámite: ${file['id']}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomCardArchives(
                  title: file['nombre_archivo'],
                  time: 'Hace 2 horas',
                  size: '604KB', // Update this to actual size if available
                  icon: Icons.picture_as_pdf,
                  IsCorrect: true,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.grey, size: 16),
                    SizedBox(width: 10),
                    Text('Última actualización: ${file['fecha_subida'] ?? 'N/A'}'),
                  ],
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedTemplate,
                  hint: Text("Seleccionar plantilla"),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTemplate = newValue;
                    });
                  },
                  items: <String>['carnet', 'boleta']
                      .map((String template) {
                        return DropdownMenuItem<String>(
                          value: template,
                          child: Text(template),
                        );
                      })
                      .toList(),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar', style: TextStyle(color: Colors.teal)),
              ),
              ElevatedButton(
                onPressed: selectedTemplate != null && !isComparing
                    ? () async {
                        setState(() {
                          isComparing = true;
                        });
                        await _compareFile(context, file['s3_url'], selectedTemplate!);
                        setState(() {
                          isComparing = false;
                        });
                      }
                    : null, // Disable if no template is selected or already comparing
                child: isComparing
                    ? CircularProgressIndicator()
                    : Text('Comparar'),
              ),
            ],
          );
        },
      );
    },
  );
  }

  Future<void> _compareFile(BuildContext context, String fileUrl, String templateType) async {
  try {
    // Construct the request with the required parameters
    final url = Uri.parse('${FilesView.baseUrl}/compare_file/');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': token,
      },
      body: jsonEncode({
        'file_url': fileUrl, // Pass the S3 URL instead of uploading the file
        'template_type': templateType,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      // Display comparison result
      _showComparisonResult(context, result['comparison_result']);
    } else {
      throw Exception('Failed to compare file: ${response.body}');
    }
  } catch (e) {
    print('Comparison error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al comparar archivo: $e')),
    );
  }
}

void _showComparisonResult(BuildContext context, Map<String, dynamic> result) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Resultado de Comparación'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: result.entries.map((entry) {
            return ListTile(
              title: Text('${entry.key}'),
              subtitle: Text(entry.value ? 'Match' : 'No Match'),
            );
          }).toList(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cerrar', style: TextStyle(color: Colors.teal)),
          ),
        ],
      );
    },
  );
}


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => files.length;

  @override
  int get selectedRowCount => 0;
}
