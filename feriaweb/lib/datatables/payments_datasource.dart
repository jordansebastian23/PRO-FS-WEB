import 'package:flutter/material.dart';

class PaymentsDatasource extends DataTableSource {
  final BuildContext context;
  final List<dynamic> pagos;

  PaymentsDatasource(this.context, this.pagos);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= pagos.length) return null;
    final pago = pagos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(pago['id'].toString())),
        DataCell(Text(pago['usuario'] ?? '')),
        DataCell(Text(pago['monto'].toString())),
        DataCell(Text(pago['fecha_creacion'] ?? '')),
        DataCell(Text(pago['estado'] ?? '')),
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
    final pago = pagos[index];
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del Pago'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ID: ${pago['id']}'),
                Text('Usuario: ${pago['usuario']}'),
                Text('Monto: ${pago['monto']}'),
                Text('Fecha de Creación: ${pago['fecha_creacion']}'),
                Text('Estado: ${pago['estado']}'),
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
  int get rowCount => pagos.length;

  @override
  int get selectedRowCount => 0;
}
