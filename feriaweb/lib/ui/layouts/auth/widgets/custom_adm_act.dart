import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class CustomAdmAct {
  static showCreateUser(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Rol',
                border: OutlineInputBorder(),
              ),
              items: ['Admin', 'User', 'Guest'].map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ],
        ),
      ),
    );
  }

  static showEditUser(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear Usuario'),
          content: SingleChildScrollView(
            child: Container(
              width: 640,
              height: 144,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: CustomInputs.createUser(
                            hint: 'Nombre',
                            label: 'Nombre',
                            colorBorder: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          decoration: CustomInputs.createUser(
                              hint: 'Apellido',
                              label: 'Apellido',
                              colorBorder: Colors.black),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          decoration: CustomInputs.createUser(
                              label: 'Correo',
                              hint: 'Correo',
                              colorBorder: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Container(
                        child: TextFormField(
                          decoration: CustomInputs.createUser(
                              hint: 'Contraseña',
                              label: 'Contraseña',
                              colorBorder: Colors.black),
                        ),
                      )),
                      SizedBox(width: 20),
                      Expanded(
                        //combo box
                        child: DropdownButtonFormField<String>(
                          decoration: CustomInputs.dropDownItem(
                              hint: 'Rol',
                              label: 'Rol',
                              colorBorder: Colors.black),
                          items: ['Admin', 'User', 'Guest'].map((String role) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Crear Usuario'),
              onPressed: () {
                // Lógica para guardar el usuario
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
