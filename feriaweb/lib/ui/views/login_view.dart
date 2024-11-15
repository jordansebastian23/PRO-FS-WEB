import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/providers/auth_provider.dart';
import 'package:feriaweb/providers/login_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:feriaweb/services/navigation_service.dart';
import 'package:feriaweb/ui/layouts/auth/widgets/custom_imputs.dart';
import 'package:flutter/material.dart';

import 'package:feriaweb/router/router.dart';

import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
  }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: ( _ ) => LoginFormProvider(),
      child: Builder(builder: ( context ){

        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);


        return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric( horizontal: 20 ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints( maxWidth: 370 ),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: loginFormProvider.formKey,
              child: Column(
                children: [
                  
                  // Email
                  TextFormField(
                    validator: ( value ) {
                      if( !EmailValidator.validate(value ?? '') ) return 'Email no válido';
                      return null;
                    },
                    controller: _emailController,
                    onChanged: ( value ) => loginFormProvider.email = value,
                    style: TextStyle( color: Colors.white ),
                    cursorColor: CustomColor.buttons,
                    decoration: CustomImputs.loginInputStyle(
                      hint: 'Ingrese su correo',
                      label: 'Email',
                      icon: Icons.email_outlined
                    ),
                  ),

                  SizedBox( height: 10 ),

                  // Password
                  TextFormField(
                    onChanged: ( value ) => loginFormProvider.password = value,
                    validator: ( value ) {
                      if ( value == null || value.isEmpty ) return 'Ingrese su contraseña';
                      if ( value.length < 6 ) return 'La contraseña debe de ser de 6 caracteres';
                      return null; // Válido
                    },
                    controller: _passwordController,
                    obscureText: true,
                    cursorColor: CustomColor.buttons,
                    style: TextStyle( color: Colors.white ),
                    decoration: CustomImputs.loginInputStyle(
                      hint: '*********',
                      label: 'Contraseña',
                      icon: Icons.lock_outline_rounded
                    ),
                  ),
                  
                  SizedBox( height: 15 ),
                  CustomOutlinedButton(
                    isFilled: true,
                    color: CustomColor.buttons,

                    onPressed: () async {
                      await authProvider.loginWithCredentials(_emailController.text, _passwordController.text);
                    }, 
                    text: 'Ingresar',
                  ),


                  SizedBox( height: 7 ),
                  LinkText(
                    text: 'Nueva cuenta',
                    onPressed: () {
                      Navigator.pushNamed( context, Flurorouter.registerRoute );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 1,
                              color: Colors.white,
                            ),
                            Text('o',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white)),
                            Container(
                              width: 100,
                              height: 1,
                              color: Colors.white,
                            ),
                          ],
                  ),
                  SizedBox( height: 5 ),
                  ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              await authProvider.loginWithGoogle();
                            },
                            icon: Image.asset(
                              'assets/icons/google_icon1.png',
                              height: 20.0,
                              width: 20.0,
                            ),
                            label: Text(
                              'Ingresar con Google',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),


                ],
              )
            ),
          ),
        ),
      );
      })
    );
  }

}