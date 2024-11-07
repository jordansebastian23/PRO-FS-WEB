import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/cards/white_card.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class NofityView extends StatefulWidget {
  const NofityView({super.key});

  @override
  State<NofityView> createState() => _NofityViewState();
}

class _NofityViewState extends State<NofityView> {
  final TextEditingController _notificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 800,
        height: 700,
        child: Container(
          child: WhiteCard(
              icon: Icons.notifications_none_outlined,
              title: 'Enviar Notificación',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      'Para enviar una notificación, escriba el correo electrónico del destinatario.'
                      'Nota: el tipo de estado está asociado al rol o cargo del usuario seleccionado.'),
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
                      SizedBox(
                        width: 10
                      ),
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
                      SizedBox(
                        width: 10
                      ),
                      SizedBox(
                        width: 237,
                        height: 43,
                        child: DropdownButtonFormField<String>(
                          decoration: CustomInputs.dropDownItem(
                              colorBorder: Colors.black,
                              hint: 'Estado',
                              label: 'Estado'),
                          items: ['Autorizacion-Retiro Carga', 'En Proceso', 'No Comenzado'].map((String role) {
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
                    height: 10,
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.amber,
                      )),
                      Expanded(
                      child: Container(
                        width: 200,
                        height: 200,
                        color : Colors.blue
                      )),
                      Expanded(
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.green
                      )),

                  ],
                ),





                  TextFormField(
                    controller: _notificationController,
                    maxLines: 5, // Permite múltiples líneas
                    decoration: InputDecoration(
                      hintText: 'Contenido de la notificación',
                      border: OutlineInputBorder(),
                    ),
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
