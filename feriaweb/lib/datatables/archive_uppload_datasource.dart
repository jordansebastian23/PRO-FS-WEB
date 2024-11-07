import 'package:feriaweb/ui/cards/custom_card_archives.dart';
import 'package:flutter/material.dart';

class ArchiveUpploadDatasource extends DataTableSource {
  late BuildContext context;
  ArchiveUpploadDatasource(this.context);


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
            _showDetailsDialog(context, index);
            
          },
          child: Text('Ver detalles',
              style: TextStyle(color: Colors.teal, fontSize: 14)),
        )),
      ],
    );
  }


void _showDetailsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles Archivo Número de Trámite: ${index + 200}'),
          content: SingleChildScrollView(
            child: Container(
              width: 800,
              child: ListBody(
                children: <Widget>[
                  Divider(
                        color: Colors.black,
                      ),
                  CustomCardArchives(
                    title:'Declaracion_De_Ingreso.pdf',
                    time: 'Hace 2 horas',
                    size: '604KB',
                    icon: Icons.picture_as_pdf,
                    IsCorrect: true,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  CustomCardArchives(
                    title:'Factura.pdf',
                    time: 'Hace 2 horas',
                    size: '604KB',
                    icon: Icons.picture_as_pdf, IsCorrect: false,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  CustomCardArchives(
                    title:'Factura.pdf',
                    time: 'Hace 2 horas',
                    size: '604KB',
                    icon: Icons.picture_as_pdf, IsCorrect: false,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  CustomCardArchives(
                    title:'Factura.pdf',
                    time: 'Hace 2 horas',
                    size: '604KB',
                    icon: Icons.picture_as_pdf, IsCorrect: false,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  CustomCardArchives(
                    title:'Factura.pdf',
                    time: 'Hace 2 horas',
                    size: '604KB',
                    icon: Icons.picture_as_pdf, IsCorrect: false,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.grey, size: 16),
                      SizedBox(width: 10),
                      Text('última actualización: Hace 2 horas',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ]
                    ,
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 1000;

  @override
  int get selectedRowCount => 0;
}
