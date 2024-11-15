import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CargaDatasource extends DataTableSource {
  late BuildContext context;
  final List<dynamic> cargas;
  CargaDatasource(this.context, this.cargas);
  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= cargas.length) return null;
    final carga = cargas[index];
    return DataRow.byIndex(
      index: index,
      // cells: [
      //   DataCell(Text('0' + (index + 1).toString(),
      //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
      //   DataCell(Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
      //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
      //   DataCell(Text(DateFormat('dd/MM/yyyy').format(DateTime.now()),
      //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
      //   DataCell(Text('CLP\$' + Random().nextInt(1000000).toString(),
      //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
      //   DataCell(Text('Completado',
      //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
      //   DataCell(TextButton(
      //     onPressed: () {
      //       _showDetailsDialog(context, index);
      //     },
      //     child: Text('Ver detalles',
      //         style: TextStyle(color: Colors.teal, fontSize: 14)),
      //   )),
      // ],
      cells: [
        DataCell(Text(carga['id'].toString())),
        DataCell(Text(carga['usuario'] ?? '')),
        DataCell(Text(carga['descripcion']  != null && carga['descripcion'].length > 15
        ? carga['descripcion'].substring(0, 15) + '...'
        : carga['descripcion'] ?? '')),
        DataCell(Text(
          carga['localizacion'] != null
              ? carga['localizacion']
            .split(',')
            .map((coord) => coord.trim().substring(0, 7))
            .join(' ')
              : '',
        )),
        DataCell(Text(DateFormat('dd/MM/yy').format(DateTime.parse(carga['fecha_creacion'])))),
        DataCell(Text(carga['fecha_retiro'] != null
            ? DateFormat('dd/MM/yy').format(DateTime.parse(carga['fecha_retiro']))
            : '')),
        DataCell(Text(carga['estado'] ?? '')),
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
    final carga = cargas[index];
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles de la carga'),
          content: SingleChildScrollView(
            child: Container(
              width: 300,
              child: ListBody(
                children: <Widget>[
                  Text('ID: ${carga['id']}'),
                  Text('Usuario: ${carga['usuario']}'),
                  Text('Descripción: ${carga['descripcion']}'),
                  Text('Localización: ${carga['localizacion']}'),
                  Text('Fecha de Creación: ${carga['fecha_creacion']}'),
                  Text('Fecha de Retiro: ${carga['fecha_retiro']}'),
                  Text('Estado: ${carga['estado']}'),             
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
                  DropdownButtonFormField<String>(
                                decoration: CustomInputs.dropDownItem(
                                    colorBorder: Colors.black,
                                    hint: 'Estado de la carga',
                                    label: 'Estado'),
                                items: ['Retired', 'Approved', 'Pending'].map((String ID) {
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
  int get rowCount => cargas.length;

  @override
  int get selectedRowCount => 0;
}
