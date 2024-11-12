import 'dart:math';
import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CargaDatasource extends DataTableSource {
  late BuildContext context;
  CargaDatasource(this.context);
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('0' + (index + 1).toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(Text('CLP\$' + Random().nextInt(1000000).toString(),
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
          title: Text('Detalles de la carga - Numero de carga ${index + 100}'),
          content: SingleChildScrollView(
            child: Container(
              width: 300,
              child: ListBody(
                children: <Widget>[
                  Text('ID Carga: 0' + (index + 1).toString()),
                  Text('Usuario asociado: \$Matias Gonzales R.'),
                  Text('Fecha de creacion: ' +DateFormat('dd/MM/yyyy').format(DateTime.now())),
                  Text('Fecha de retiro: ' + DateFormat('dd/MM/yyyy').format(DateTime.now())),
                  Text('Monto Asociado: CLP\$' + Random().nextInt(1000000).toString()),
                  Text('Estado: Pendiente'),                  
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
          title: Text('Editar Carga'),
          content: SingleChildScrollView(
            child: Container(
              width: 300,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: CustomInputs.createUser(
                      colorBorder: Colors.black,
                      hint: 'Monto Relacionado',
                      label: 'Monto',
                      //labelText: 'Nombre',
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                                decoration: CustomInputs.dropDownItem(
                                    colorBorder: Colors.black,
                                    hint: 'Estado de la carga',
                                    label: 'Estado'),
                                items: ['Completado', 'Pendiente', 'No autorizado'].map((String ID) {
                                  return DropdownMenuItem<String>(
                                    value: ID,
                                    child: Text(ID),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {},
                              ),
                  SizedBox(height: 10),
                  //date picker
                  //form datepicker
                    TextField(
                    decoration: CustomInputs.createUser(
                      colorBorder: Colors.black,
                      hint: 'Fecha de retiro',
                      label: 'Fecha de retiro',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                      // Handle the selected date
                      }
                    },
                    ),
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
