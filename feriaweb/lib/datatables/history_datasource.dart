import 'dart:math';
import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/cards/custom_card_procedures_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryDatasource extends DataTableSource {
  late BuildContext context;
  HistoryDatasource(this.context);
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('05/10/2021',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('202',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('202',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('LCL Directo',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text(
            'Matias Gonzales R.'.length > 14
                ? 'Matias Gonzales R.'.substring(0, 14) + '...'
                : 'Matias Gonzales R.',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('factura.pdf',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('Completado',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        
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

  void _showDetailsDialog(context, int index) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Detalles'),
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            
          ),
          content: SingleChildScrollView(
            child: Container(
              width: 540,
              child: ListBody(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCardProceduresDetails(
                          icon: Icons.calendar_today,
                          bgColor: Colors.blueAccent,
                          title: 'Trámite N°: 122',
                          subTitle: 'ID Destinatario: 122',
                        ),
                        SizedBox(height: 10)
                        ,CustomCardProceduresDetails(
                          icon: Icons.picture_as_pdf_outlined,
                          bgColor: CustomColor.details,
                          showButtons: true,
                          title: 'Boleta de pago.pdf',
                          subTitle: 'ID Destinatario: 122',
                        ),
                        SizedBox(height: 10)
                        ,CustomCardProceduresDetails(
                          icon: Icons.picture_as_pdf_outlined,
                          bgColor: CustomColor.details,
                          showButtons: true,
                          title: 'Archivo de retiro.pdf',
                          subTitle: 'ID Destinatario: 122',
                        ),
                        SizedBox(height: 10)
                        ,CustomCardProceduresDetails(
                          icon: Icons.picture_as_pdf_outlined,
                          bgColor: CustomColor.details,
                          showButtons: true,
                          title: 'Carnet.pdf',
                          subTitle: 'ID Destinatario: 122',
                        ),
                        SizedBox(height: 10)
                        ,CustomCardProceduresDetails(
                          icon: Icons.picture_as_pdf_outlined,
                          bgColor: CustomColor.details,
                          showButtons: true,
                          title: 'Carnet Conductor.pdf',
                          subTitle: 'ID Destinatario: 122',
                        ),
                        SizedBox(height: 10)
                        ,CustomCardProceduresDetails(
                          icon: Icons.picture_as_pdf_outlined,
                          bgColor: CustomColor.details,
                          showButtons: true,
                          title: 'Archivo Aduana.pdf',
                          subTitle: 'ID Destinatario: 122',
                        ),
                        SizedBox(height: 10)
                        ,CustomCardProceduresDetails(
                          icon: Icons.picture_as_pdf_outlined,
                          bgColor: CustomColor.details,
                          showButtons: true,
                          title: 'Archivo de visado.pdf',
                          subTitle: 'ID Destinatario: 122',
                        ),
                        
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          actions: <Widget>[
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    
                  },
                  text: 'Cerrar',
                  isFilled: true,
                  color: CustomColor.buttons,
                ),
                SizedBox(width: 10),
                CustomOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Confirmar',
                  isFilled: true,
                  color: CustomColor.buttons,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Pago'),
          content: SingleChildScrollView(
            child: Container(
              width: 300,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      //labelText: 'N tramite',
                      hintText: '202',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Matias Gonzales R.',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Monto',
                      hintText: 'CLP\$${Random().nextInt(1000000)}',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Estado',
                      hintText: 'Completado',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Tarjeta',
                      hintText: '**** 1234',
                    ),
                  ),
                  // Agrega más campos según sea necesario
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                //_showEditDialog(context, index);
              },
              text: 'Cerrar',
              isFilled: true,
              color: CustomColor.buttons,
            ),
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Guardar',
              isFilled: true,
              color: CustomColor.buttons,
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
