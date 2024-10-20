import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
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
                decoration: buildinputdecorator(
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
                decoration: buildinputdecorator(
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

  InputDecoration buildinputdecorator({
    required String hint,
    required String label,
    required IconData icon}) {


    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)
        ),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
      labelStyle: TextStyle(color: Colors.grey),
    );
  }
}
