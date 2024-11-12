import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/layouts/auth/widgets/custom_imputs.dart';
import 'package:feriaweb/providers/register_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:feriaweb/router/router.dart';

import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => RegisterFormProvider(),
      child: Builder(builder: (context) {

        final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric( horizontal: 20 ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints( maxWidth: 370 ),
              child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: registerFormProvider.formKey,
                child: Column(
                  children: [

                    //Email
                    TextFormField(
                      onChanged: (value) => registerFormProvider.name = value,

                      validator: (value) {
                        if (value == null || value.isEmpty) return 'El campo es obligatorio';
                        if (value.length < 3) return 'El nombre debe de ser de 3 caracteres';
                        if (value.length > 100) return 'El nombre no debe de ser mayor a 100 caracteres';
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      cursorColor: CustomColor.buttons,
                      decoration: CustomImputs.loginInputStyle(
                        hint: 'Ingrese su nombre',
                        label: 'Nombre',
                        icon: Icons.supervised_user_circle_sharp,
                      ),
                    ),
                    SizedBox(height: 10),
                    //Email
                    TextFormField(
                      cursorColor: CustomColor.buttons,
                      validator: (value) {
                            //libreria email_validator
                            if ( !EmailValidator.validate(value ?? '') ) return 'Email no valido';

                            return null;
                          },
                          onChanged: (value) => registerFormProvider.email = value,
                      style: TextStyle(color: Colors.white),
                      decoration: CustomImputs.loginInputStyle(
                        hint: 'Email',
                        label: 'Email',
                        icon: Icons.email_outlined,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      cursorColor: CustomColor.buttons,
                      onChanged: (value) => registerFormProvider.phone = value,

                          validator: (value) {
                            if (value == null || value.isEmpty) return 'El campo es obligatorio';
                            if (value.length < 10) return 'El numero de telefono debe de ser de 10 caracteres';
                            return null;
                          },
                      style: TextStyle(color: Colors.white),
                      decoration: CustomImputs.loginInputStyle(
                        hint: 'Numero de telefono',
                        label: 'Numero de telefono',
                        icon: Icons.phone_iphone_outlined,
                      ),
                    ),
                    SizedBox(height: 10),
                    //password
                    TextFormField(
                      cursorColor: CustomColor.buttons,
                      onChanged: (value) => registerFormProvider.password = value,

                          validator: ( value ) {
                            if (value == null || value.isEmpty) return 'El campo es obligatorio';
                            if (value.length < 6) return 'La contraseña debe de ser de 6 caracteres';
                            return null;
                          },
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: CustomImputs.loginInputStyle(
                        hint: '********',
                        label: 'Password',
                        icon: Icons.lock_outline,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      cursorColor: CustomColor.buttons,
                      onChanged: (value) => registerFormProvider.password = value,

                          validator: ( value ) {
                            if (value == null || value.isEmpty) return 'El campo es obligatorio';
                            if (value.length < 6) return 'La contraseña debe de ser de 6 caracteres';
                            return null;
                          },
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: CustomImputs.loginInputStyle(
                        hint: '********',
                        label: 'Confirma tu contraseña',
                        icon: Icons.lock_outline,
                      ),
                    ),
                    
                    SizedBox( height: 20 ),
                    CustomOutlinedButton(
                      isFilled: true,
                      color: CustomColor.buttons,
                      onPressed: () {

                        registerFormProvider.validateForm();

                      }, 
                      text: 'Crear cuenta',
                    ),


                    SizedBox( height: 20 ),
                    LinkText(
                      text: 'Ir al login',
                      onPressed: () {
                        Navigator.pushNamed(context, Flurorouter.loginRoute );
                      },
                    )

                  ],
                )
              ),
            ),
          ),
        );

      }),
    );
  }

  
}