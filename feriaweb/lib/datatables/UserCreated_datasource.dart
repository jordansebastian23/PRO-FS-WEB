import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class UsersCreated extends DataTableSource {
  late BuildContext context;

  UsersCreated(this.context);

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
        DataCell(Text('+56913336090',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
        DataCell(TextButton(
          onPressed: () {
            _showEditDialog(context, index);
          },
          child: Text('Editar Informacion',
              style: TextStyle(color: Colors.teal, fontSize: 14)),
        )),
      ],
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text('Editar Usuario '),
              Expanded(
                child: TextButton(
                onPressed: (){},
                child: Text('Deshabilitar', style: TextStyle(color: CustomColor.buttons),)) )
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width: 300,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: 'Jordan Navarrete',
                      decoration: CustomInputs.createUser(
                          colorBorder: Colors.black,
                          hint: 'Nombre',
                          label: 'Nombre')),
                  SizedBox(height: 10),
                    TextFormField(
                      initialValue: 'jordansebastian50@gmail.com',
                      decoration: CustomInputs.createUser(
                        colorBorder: Colors.black,
                        hint: 'Email',
                        label: 'Email')),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: CustomInputs.dropDownItem(
                        colorBorder: Colors.black, hint: 'Rol', label: 'Rol'),
                    items: ['Admin', 'User', 'Guest'].map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                          initialValue: '*******',
                          obscureText: true,
                      decoration: CustomInputs.createUser(
                          colorBorder: Colors.black,
                          hint: 'Contraseña',
                          label: 'Contraseña')),
                  SizedBox(height: 10),
                  TextFormField(
                          initialValue: '*******',
                          obscureText: true,
                      decoration: CustomInputs.createUser(
                          colorBorder: Colors.black,
                          hint: 'Contraseña',
                          label: 'Contraseña')),
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
