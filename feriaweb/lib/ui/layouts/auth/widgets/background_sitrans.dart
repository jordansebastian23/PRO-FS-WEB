import 'package:flutter/material.dart';

class BackgroundSitrans extends StatelessWidget {
  const BackgroundSitrans({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Container(
            decoration: buildBoxDecoration(),
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: CircleAvatar(
                    radius: 100,
                    child: Image.asset('assets/icons/Logo - logiquick.png',
                    width: 427, height: 394,
                    
                    ),
                  ),
                ),
              ),
            ),

          ),
        );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/FondoLogin.png'),
      fit: BoxFit.cover
    )
  );
}