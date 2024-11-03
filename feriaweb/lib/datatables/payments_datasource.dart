import 'dart:math';
import 'package:flutter/material.dart';

class PaymentsDatasource extends DataTableSource {
  late BuildContext context;
  PaymentsDatasource(this.context);
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('0'+ (index+1).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text(''+ (index+100).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('Carga Sueltac   ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text(
            'Matias Gonzales R.'.length > 14
                ? 'Matias Gonzales R.'.substring(0, 14) + '...'
                : 'Matias Gonzales R.',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        
        DataCell(Text('CLP\$'+ Random().nextInt(1000000).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('Completado',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
            DataCell(
              Row(
              children: [
                Icon(Icons.credit_card_outlined, size: 20, color: Colors.black),
                SizedBox(width: 2),
                Text('**** 1234',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            )),
        DataCell(TextButton(
          onPressed: () {
            _showDetailsDialog( context , index);
          },
          child: Text('Ver detalles',
              style: TextStyle(color: Colors.teal, fontSize: 14)),
        )),
      ],
    );

  }

   void _showDetailsDialog(context , int index) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del Pago'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ID del Pago: ${index + 1}'),
                Text('Nombre: Matias Gonzales R.'),
                Text('Monto: CLP\$${Random().nextInt(1000000)}'),
                Text('Estado: Completado'),
                Text('Tarjeta: **** 1234'),
                // Agrega más detalles según sea necesario
              ],
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
