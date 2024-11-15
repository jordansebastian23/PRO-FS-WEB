import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/cards/custom_card_notify.dart';
import 'package:feriaweb/ui/cards/white_card.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class NofityView extends StatefulWidget {
  const NofityView({super.key});

  @override
  State<NofityView> createState() => _NofityViewState();
}

class _NofityViewState extends State<NofityView> {
  int _selectedRadio = 1;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 1000,
        height: 700,
        child: Container(
          padding: EdgeInsets.all(10),
          child: WhiteCard(
              icon: Icons.notifications_none_outlined,
              title: 'Enviar Notificación',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      'Para enviar una notificación, escriba el correo electrónico del destinatario. A continuación seleccione el rol o cargo del usuario y seleccione el tipo de estado.'
                      'Nota: el tipo de estado está asociado al rol o cargo del usuario seleccionado.'
                      'Luego, seleccione el tipo de notificación: Advertencia o Error (Rojo); Pendiente (Amarillo); Aviso (azul).'),
                  SizedBox(height: 20),
                  Row(
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
                        width: 183,
                        height: 43,
                        child: DropdownButtonFormField<String>(
                          decoration: CustomInputs.dropDownItem(
                              colorBorder: Colors.black,
                              hint: 'Rol',
                              label: 'Rol'),
                          items: ['Admin', 'User', 'Guest'].map((String role) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 237,
                        height: 43,
                        child: DropdownButtonFormField<String>(
                          decoration: CustomInputs.dropDownItem(
                              colorBorder: Colors.black,
                              hint: 'Estado',
                              label: 'Estado'),
                          items: [
                            'Autorizacion-Retiro Carga',
                            'En Proceso',
                            'No Comenzado'
                          ].map((String role) {
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCardNotify(
                        icon: Icons.error_outline_outlined,
                        title: 'LogiQuick • Ahora',
                        state: '(Estado asociado)',
                        textRadio: 'Error / Advetencia',
                        colorBorder: Colors.red,
                        colorIcon: Colors.red,
                        value: 1,
                      groupValue: _selectedRadio,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedRadio = value!;
                        });
                      },
                      ),
                      CustomCardNotify(
                        icon: Icons.error_outline_outlined,
                        title: 'LogiQuick • Hace 3 Minutos',
                        state: '(Estado asociado)',
                        textRadio: 'Pendiente',
                        colorBorder: Colors.amber,
                        colorIcon: Colors.amber,
                        value: 2,
                      groupValue: _selectedRadio,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedRadio = value!;
                        });
                      },
                      ),
                      CustomCardNotify(
                        icon: Icons.error_outline_outlined,
                        title: 'LogiQuick • Hace 5 Minutos',
                        state: '(Estado asociado)',
                        textRadio: 'Aviso',
                        colorBorder: const Color.fromARGB(255, 22, 107, 255),
                        colorIcon: const Color.fromARGB(255, 22, 107, 255),
                        value: 3,
                      groupValue: _selectedRadio,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedRadio = value!;
                        });
                      },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomOutlinedButton(
                    isFilled: true,
                    color: CustomColor.buttons,
                    onPressed: () {},
                    text: 'Enviar Notificación',
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
