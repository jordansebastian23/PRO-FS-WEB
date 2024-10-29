import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';

  validateForm(){
    if ( formKey.currentState!.validate() ) {
      print('Formulario valido');
      print('$name === $email === $phone === $password === $confirmPassword');
    } else {
      print('Formulario invalido');
    }
  }

}