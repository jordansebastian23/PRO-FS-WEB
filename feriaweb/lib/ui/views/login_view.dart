import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/inputs/custom_imputs.dart';
import 'package:feriaweb/ui/layouts/auth/widgets/link_text.dart';

import 'package:feriaweb/router/router.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 370),
          child: Form(
              child: Column(
            children: [
              //Email
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: CustomImputs.loginInputStyle(
                  hint: 'Email',
                  label :'Email',
                  icon: Icons.email_outlined,
                ),
              ),
              SizedBox(height: 20),
              //password
              TextFormField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: CustomImputs.loginInputStyle(
                  hint: '********',
                  label :'Password',
                  icon: Icons.lock_outline,
                ),
              ),
              SizedBox(height: 20),
              //crear nueva cuenta

              //Button
              CustomOutlinedButton(onPressed: (){},
              text: 'Ingresar',
              textColor: CustomColor.background,
              color: Colors.white,
              isFilled: true,
              ),

              LinkText(
                text: 'Crear una cuenta',
                onPressed: () {
                  Navigator.pushNamed(context, Flurorouter.registerRoute);
                },
              ),
              
            ],
          )),
        ),
      ),
    );
  }
}
