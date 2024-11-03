import 'package:flutter/material.dart';

class UsersCreated extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('0' + (index + 1).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('Camionero',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text(
            'jordansebastian50@gmail.com'.length > 14
                ? 'jordansebastian50@gmail.com'.substring(0, 14) + '...'
                : 'jordansebastian50@gmail.com',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('*******',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('CLP\$7.233.457',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(TextButton(
          onPressed: () {
            // Acción para realizar pago
          },
          child: Text('Editar Informacion',
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
