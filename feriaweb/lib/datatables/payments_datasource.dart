import 'package:flutter/material.dart';

class PaymentsDatasource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('108',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('LCL Directo',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text(
            'Edmundo Fernández C.'.length > 14
                ? 'Edmundo Fernández C.'.substring(0, 14) + '...'
                : 'Edmundo Fernández C.',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('CLP\$7.233.457',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('Pendiente',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('-',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(TextButton(
          onPressed: () {
            // Acción para realizar pago
          },
          child: Text('Realizar pago',
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
