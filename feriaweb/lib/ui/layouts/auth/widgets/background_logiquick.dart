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
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 100,
              child: Image(
                image: AssetImage('logiquick-logo.png'),
                width: 400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('FondoLogin.png'),
          fit: BoxFit.cover
        )
    );
  }
}

