import 'package:flutter/material.dart';

class BackgroundLogiQuick extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: BoxConstraints( maxWidth: 400 ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        image: DecorationImage(
          opacity: 0.2,
          
          image: AssetImage('assets/Fondo.webp'),
          fit: BoxFit.cover
        )
    );
  }
}

