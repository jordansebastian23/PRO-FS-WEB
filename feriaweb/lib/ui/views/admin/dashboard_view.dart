import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/datatables/UserCreated_datasource.dart';
import 'package:feriaweb/services/create_account.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:feriaweb/services/get_roles.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _showCreateUserForm = false;
  bool _showEditUserForm = false;
  bool _showDeleteUser = false;
  bool _showExtraContainerCreateUser = false;

    final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoMaternoController = TextEditingController();
  final TextEditingController _apellidoPaternoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  List<String> _roles = [];
  String? _selectedRole;

  void initState() {
    super.initState();
    _loadRoles();
  }

  void dispose() {
    _nombreController.dispose();
    _apellidoMaternoController.dispose();
    _apellidoPaternoController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadRoles() async {
    try {
      final roles = await RoleService.fetchRoles();
      setState(() {
        _roles = roles;
      });
    } catch (e) {
      print('Error loading roles: $e');
    }
  }

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
                        text: 'Eliminar Usuario',
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
                                    controller: _nombreController,
                                    decoration: CustomInputs.createUser(
                                      colorBorder: Colors.black,
                                      hint: 'Nombre',
                                      label: 'Nombre',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _apellidoMaternoController,
                                    decoration: CustomInputs.createUser(
                                      colorBorder: Colors.black,
                                      hint: 'Apellido Materno',
                                      label: 'Apellido Materno',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _apellidoPaternoController,
                                    decoration: CustomInputs.createUser(
                                      colorBorder: Colors.black,
                                      hint: 'Apellido Paterno',
                                      label: 'Apellido Paterno',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: CustomInputs.createUser(
                                      colorBorder: Colors.black,
                                      hint: 'Correo Electronico',
                                      label: 'Correo Electronico',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 250,
                                  child: TextFormField(
                                    controller: _phoneNumberController,
                                    decoration: CustomInputs.createUser(
                                      colorBorder: Colors.black,
                                      hint: 'Numero Telefono',
                                      label: 'Numero Telefono',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: CustomInputs.createUser(
                                      colorBorder: Colors.black,
                                      hint: 'Contraseña',
                                      label: 'Contraseña',
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    decoration: CustomInputs.createUser(
                                      colorBorder: Colors.black,
                                      hint: 'Confirmar Contraseña',
                                      label: 'Confirmar Contraseña',
                                    ),
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
                                      label: 'Rol',
                                    ),
                                    items: _roles.map((String role) {
                                      return DropdownMenuItem<String>(
                                        value: role,
                                        child: Text(role),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedRole = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: CustomOutlinedButton(
                                onPressed: () async {
                                  try {
                                    final displayName =
                                        '${_nombreController.text} ${_apellidoPaternoController.text} ${_apellidoMaternoController.text}';
                                    final result = await CreateAccountService.createUser(
                                      email: _emailController.text,
                                      displayName: displayName,
                                      phoneNumber: _phoneNumberController.text,
                                      password: _passwordController.text,
                                      role: _selectedRole ?? 'Tramites', // Default role if none selected
                                    );
                                    print('User created: $result');
                                  } catch (e) {
                                    print('Error creating user: $e');
                                  }
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
                                  text: 'Eliminar Usuario'),
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
                  source: UsersCreated(),
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
