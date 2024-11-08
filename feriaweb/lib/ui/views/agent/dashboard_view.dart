import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/datatables/UserCreated_datasource.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _showCreateUserForm = false;
  bool _showEditUserForm = false;
  bool _showDeleteUser = false;
  bool _showExtraContainerCreateUser = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 900,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: buildBoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.dashboard,
                        size: 25,
                        color: Colors.black,
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Administrar usuarios',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                    endIndent: 30,
                    indent: 30,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomOutlinedButton(
                        onPressed: () {
                          setState(() {
                            _showCreateUserForm = !_showCreateUserForm;
                            if (_showCreateUserForm) {
                              _showEditUserForm = false;
                              _showDeleteUser = false;
                              _showExtraContainerCreateUser = false;
                            }
                          });
                        },
                        text: 'Crear usuario',
                        isFilled: true,
                        color: CustomColor.buttons,
                      ),
                      SizedBox(width: 20),
                      CustomOutlinedButton(
                        onPressed: () {
                          setState(() {
                            _showEditUserForm = !_showEditUserForm;
                            if (_showEditUserForm) {
                              _showCreateUserForm = false;
                              _showDeleteUser = false;
                              _showExtraContainerCreateUser = false;
                            }
                          });
                        },
                        text: 'Editar usuario',
                        isFilled: true,
                        color: CustomColor.buttons,
                      ),
                      SizedBox(width: 20),
                      CustomOutlinedButton(
                        onPressed: () {
                          setState(() {
                            _showDeleteUser = !_showDeleteUser;
                            if (_showDeleteUser) {
                              _showCreateUserForm = false;
                              _showEditUserForm = false;
                              _showExtraContainerCreateUser = false;
                            }
                          });
                        },
                        text: 'Deshabilitar usuario',
                        isFilled: true,
                        color: CustomColor.buttons,
                      ),
                    ],
                  ),
                  if (_showCreateUserForm)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Nombre',
                                          label: 'Nombre')),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Apellido Materno',
                                          label: 'Apellido Materno')),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Apellido Paterno',
                                          label: 'Apellido Paterno')),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Correo Electronico',
                                          label: 'Correo Electronico')),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Numero Telefono',
                                          label: 'Numero Telefono')),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: CustomInputs.createUser(
                                        colorBorder: Colors.black,
                                        hint: 'Contraseña',
                                        label: 'Contraseña'),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    decoration: CustomInputs.createUser(
                                        colorBorder: Colors.black,
                                        hint: 'Contraseña',
                                        label: 'Contraseña'),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 100,
                                  child: DropdownButtonFormField<String>(
                                    decoration: CustomInputs.dropDownItem(
                                        colorBorder: Colors.black,
                                        hint: 'Rol',
                                        label: 'Rol'),
                                    items: ['Admin', 'User', 'Guest']
                                        .map((String role) {
                                      return DropdownMenuItem<String>(
                                        value: role,
                                        child: Text(role),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: CustomOutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _showExtraContainerCreateUser =
                                        !_showExtraContainerCreateUser;
                                  });
                                },
                                text: 'Crear usuario',
                                isFilled: true,
                                color: CustomColor.buttons,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_showEditUserForm)
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: DropdownButtonFormField<String>(
                                decoration: CustomInputs.dropDownItem(
                                    colorBorder: Colors.black,
                                    hint: 'ID Usuario',
                                    label: 'ID Usuario'),
                                items: ['01', '02', '03'].map((String ID) {
                                  return DropdownMenuItem<String>(
                                    value: ID,
                                    child: Text(ID),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {},
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Nombre',
                                          label: 'Nombre')),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Apellido Materno',
                                          label: 'Apellido Materno')),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Apellido Paterno',
                                          label: 'Apellido Paterno')),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'Correo Electronico',
                                          label: 'Correo Electronico')),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 100,
                                  child: DropdownButtonFormField<String>(
                                    decoration: CustomInputs.dropDownItem(
                                        colorBorder: Colors.black,
                                        hint: 'Rol',
                                        label: 'Rol'),
                                    items: ['Admin', 'User', 'Guest']
                                        .map((String role) {
                                      return DropdownMenuItem<String>(
                                        value: role,
                                        child: Text(role),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      decoration: CustomInputs.createUser(
                                          colorBorder: Colors.black,
                                          hint: 'N° Telefono',
                                          label: 'N° Telefono')),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    decoration: CustomInputs.createUser(
                                        colorBorder: Colors.black,
                                        hint: 'Contraseña',
                                        label: 'Contraseña'),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    decoration: CustomInputs.createUser(
                                        colorBorder: Colors.black,
                                        hint: 'confirmar Contraseña',
                                        label: 'Confirmar Contraseña'),
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: CustomOutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showExtraContainerCreateUser =
                                          !_showExtraContainerCreateUser;
                                    });
                                  },
                                  isFilled: true,
                                  color: CustomColor.buttons,
                                  text: 'Guardar Cambio'),
                            )
                          ],
                        ))),
                  if (_showDeleteUser)
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: DropdownButtonFormField<String>(
                                decoration: CustomInputs.dropDownItem(
                                    colorBorder: Colors.black,
                                    hint: 'ID Usuario',
                                    label: 'ID Usuario'),
                                items: ['01', '02', '03'].map((String ID) {
                                  return DropdownMenuItem<String>(
                                    value: ID,
                                    child: Text(ID),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {},
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: CustomOutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showExtraContainerCreateUser =
                                          !_showExtraContainerCreateUser;
                                    });
                                  },
                                  isFilled: true,
                                  color: CustomColor.buttons,
                                  text: 'Deshabilitar Usuario'),
                            )
                          ],
                        )))
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        //Fuera del contenedor principal
        if (_showExtraContainerCreateUser)
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 900,
              child: Container(
                decoration: buildBoxDecoration(),
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                child: PaginatedDataTable(
                  arrowHeadColor: CustomColor.buttons,
                  headingRowColor: WidgetStateProperty.all(Colors.transparent),
                  columnSpacing: 2,
                  columns: [
                    DataColumn(
                        label: Text('ID Usuario',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Rol',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Correo',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Contraseña',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Numero Telefono',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Editar Informacion',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  source: UsersCreated(context),
                  header: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.group_outlined, size: 25, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Usuarios Creados',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                    ],
                  ),
                  rowsPerPage: 4,
                ),
              ),
            ),
          ),
      ],
    );
  }
}



BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    );
