import 'dart:math';
import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:flutter/material.dart';

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
          title: Text('Detalles de tramite - Numero de carga ${index + 100}'),
          content: SingleChildScrollView(
            child: Container(
              width: 300,
              child: ListBody(
                children: <Widget>[
                  Text('05/10/2021'),
                  Text('202'),
                  Text('202'),
                  Text('LCL Directo'),
                  Text('Matias Gonzales R.'),
                  Text('factura.pdf'),
                  Text('Pendiente'),
                  Row(
                    children: [
                      Text('Estado: Completado'),
                      SizedBox(width: 10),
                      TextButton(onPressed: (){},
                      child: Text('Notificar', style: TextStyle(color: Colors.teal),),
                      ),
                    ],
                  ),
                  //Método de pago
                  Text('Tarjeta: **** 1234'),
                  // Agrega más detalles según sea necesario
                ],
              ),
            ),
          ),
          actions: <Widget>[
            
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditDialog(context, index);
              },
              text: 'Editar',
              isFilled: true,
              color: CustomColor.buttons,
            ),
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Cerrar',
              isFilled: true,
              color: CustomColor.buttons,
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
