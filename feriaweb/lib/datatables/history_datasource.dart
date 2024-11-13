import 'dart:math';
import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/services/tramite_view.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/cards/custom_card_procedures_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryDatasource extends DataTableSource {
  late BuildContext context;
  final List<dynamic> tramites;
  HistoryDatasource(this.context, this.tramites);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= tramites.length) return null;
    final tramite = tramites[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(tramite['fecha_creacion'])))),
        DataCell(Text(tramite['id'].toString())),
        DataCell(Text(tramite['carga_id']?.toString() ?? '')),
        DataCell(Text(tramite['tipo_tramite'] ?? '')),
        DataCell(Text(tramite['usuario_destino'] ?? '')),
        DataCell(Text(tramite['fecha_termino'] != null 
            ? DateFormat('dd/MM/yyyy').format(DateTime.parse(tramite['fecha_termino'])) 
            : 'N/A')),
        DataCell(Text(tramite['estado'] ?? '')),
        DataCell(TextButton(
          onPressed: () {
            _showDetailsDialog(context, index);
          },
          child: Text('Ver detalles',
              style: TextStyle(color: Colors.teal, fontSize: 14)),
        )),
      ],
    );
  }

  void _showDetailsDialog(BuildContext context, int index) async {
  final tramite = tramites[index];
  final tramiteId = tramite['id'];

  try {
    // Fetch the required files for this tramite
    final requiredFiles = await TramiteService.fetchRequiredFiles(tramiteId);

    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Detalles del Trámite'),
          content: SingleChildScrollView(
            child: Column(
              children: requiredFiles.map<Widget>((file) {
                final fileType = file['file_type'];
                final fileStatus = file['status'];
                final fileUrl = file['file_url'];

                return CustomCardProceduresDetails(
                  icon: Icons.picture_as_pdf_outlined,
                  bgColor: CustomColor.details,
                  title: fileType,
                  subTitle: 'Estado: $fileStatus',
                  showButtons: fileStatus == 'pending',
                  onApprove: () => _approveFile(file['archivo_id']),
                  onReject: () => _rejectFile(file['archivo_id']),
                  onReview: fileUrl != null ? () => _openFileUrl(fileUrl) : null,
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar', style: TextStyle(color: CustomColor.buttons)),
            ),
          ],
        );
      },
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error loading tramite details: $e')),
    );
  }
}

// Helper method to open a file URL
void _openFileUrl(String fileUrl) async {
  final Uri url = Uri.parse(fileUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $fileUrl';
  }
}

void _approveFile(int archivoId) async {
  try {
    await TramiteService.approveFile(archivoId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Archivo aprobado exitosamente')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to approve file: $e')),
    );
  }
}

void _rejectFile(int archivoId) async {
  try {
    await TramiteService.rejectFile(archivoId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Archivo rechazado exitosamente')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to reject file: $e')),
    );
  }
}


  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tramites.length;

  @override
  int get selectedRowCount => 0;
}
