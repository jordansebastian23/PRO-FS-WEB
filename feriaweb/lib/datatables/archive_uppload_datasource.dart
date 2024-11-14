import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/cards/custom_card_archives.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feriaweb/services/files_view.dart';

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
        DataCell(Text(file['tipo_archivo'] ?? 'Unknown Type')),
        DataCell(Text(file['estado_procesamiento'] ?? 'Unknown Status')),
        DataCell(Text(file['nombre_archivo'])),
        DataCell(TextButton(
          onPressed: () {
            _showDetailsDialog(context, file);
          },
          child: Text('Ver detalles', style: TextStyle(color: Colors.teal)),
        )),
      ],
    );
  }

  void _showDetailsDialog(BuildContext context, Map<String, dynamic> file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles Archivo Número de Trámite: ${file['id']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomCardArchives(
                title: file['nombre_archivo'],
                time: 'Hace 2 horas',
                size: '604KB', // You can update this to actual size if available
                icon: Icons.picture_as_pdf,
                IsCorrect: true,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.grey, size: 16),
                  SizedBox(width: 10),
                  Text('última actualización: ${file['fecha_subida'] ?? 'N/A'}'),
                ],
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
