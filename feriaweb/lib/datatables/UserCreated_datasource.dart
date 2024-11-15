import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/services/edit_account.dart';
import 'package:feriaweb/services/get_roles.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class UsersCreated extends DataTableSource {
  final BuildContext context;
  final List<dynamic> users;

  UsersCreated(this.context, this.users);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= users.length) return null;
    final user = users[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user['id'].toString())),
        DataCell(Text(user['display_name']?.split(' ').take(2).join(' ') ?? '')),
        DataCell(Text(user['roles'] != null && user['roles'].isNotEmpty
            ? user['roles'].join(', ')
            : 'No role')),
        DataCell(Text(user['email'] ?? '')),
        DataCell(Text(user['phone_number'] ?? '')),
        DataCell(Text(user['disabled'] == true ? 'Deshabilitado' : 'Habilitado')),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Add your edit logic here
            _showEditDialog(context, index);
          },
        )),
      ],
    );
  }

  void _showEditDialog(BuildContext context, int index) async {
    final user = users[index];
    final TextEditingController displayNameController =
        TextEditingController(text: user['display_name']);
    final TextEditingController phoneNumberController =
        TextEditingController(text: user['phone_number']);
    final TextEditingController emailController = 
        TextEditingController(text: user['email']);

    String selectedRole = user['roles'].isNotEmpty ? user['roles'][0] : 'User';

    // Obtener todos los roles disponibles
    List<String> allRoles = await RoleService.fetchRoles();

    // Filtrar los roles que ya están asignados al usuario
    List<String> availableRoles =
        allRoles.where((role) => !user['roles'].contains(role)).toList();

    // Asegúrate de que el rol seleccionado esté en la lista de roles disponibles
    if (!availableRoles.contains(selectedRole)) {
      availableRoles.add(selectedRole);
    }

    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Row(
            children: [
              Text('Editar Usuario'),
              Expanded(
              child: TextButton(
                onPressed: () async {
                if (user['disabled'] == true) {
                  await EditAccountService.enableUser(email: user['email']);
                } else {
                  await EditAccountService.disableUser(email: user['email']);
                }
                Navigator.of(context).pop();
                },
                child: Text(
                user['disabled'] == true ? 'Habilitar' : 'Deshabilitar',
                style: TextStyle(color: CustomColor.buttons),
                ),
              ),
              ),
            ],
            ),
          content: SingleChildScrollView(
            child: Container(
              width: 300,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    decoration: CustomInputs.createUser(
                      colorBorder: Colors.black,
                      hint: 'Email',
                      label: 'Email',
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: displayNameController,
                    decoration: CustomInputs.createUser(
                      colorBorder: Colors.black,
                      hint: 'Nombre',
                      label: 'Nombre',
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: CustomInputs.dropDownItem(
                      colorBorder: Colors.black,
                      hint: 'Rol',
                      label: 'Rol',
                    ),
                    items: availableRoles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedRole = newValue!;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: CustomInputs.createUser(
                      colorBorder: Colors.black,
                      hint: 'Número de Teléfono',
                      label: 'Número de Teléfono',
                    ),
                  )
                  // Agrega más campos según sea necesario
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Cerrar',
              isFilled: true,
              color: CustomColor.buttons,
            ),
            // TODO: Actualizar la lista cuando se guarde o se hagan cambios en el estado del usuario
            CustomOutlinedButton(
              onPressed: () async {
                await EditAccountService.editUser(
                  email: emailController.text,
                  displayName: displayNameController.text,
                  phoneNumber: phoneNumberController.text,
                  role: selectedRole,
                );
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
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
