import 'package:flutter/material.dart';

class ArchiveUpploadDatasource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        //ID del usuario
        DataCell(Text('0' + (index + 1).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        //Numero de tramite
        DataCell(Text('' + (index + 200).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        //Numero de carga
        DataCell(Text((index + 100).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        //Tipo de carga
        DataCell(Text('Carga Suelta',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        //Archivos faltantes
        DataCell(Text('3',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        //Tipo de archivos .pdf
        DataCell(Text(
          'Factura.pdf, Guia de despacho.pdf, Certificado de origen.pdf'.length > 10 
            ? 'Factura.pdf, Guia de despacho.pdf, Certificado de origen.pdf'.substring(0, 11) + '...' 
            : 'Factura.pdf, Guia de despacho.pdf',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        //Estado de Subida
        DataCell(Text('Pendiente',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        //Boton para ver detalles
        DataCell(TextButton(
          onPressed: () {
            // Acción para ver detalles
          },
          child: Text('Ver detalles',
              style: TextStyle(color: Colors.teal, fontSize: 14)),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 1000;

  @override
  int get selectedRowCount => 0;
}
