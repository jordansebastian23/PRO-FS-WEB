import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            child: Image.asset('assets/icons/Logo - logiquick.png',
            width: 100,
            height: 100),
          ),

          SizedBox(height: 20),

          FittedBox(
            fit: BoxFit.contain,
            child: Text('LogiQuick',
            style: GoogleFonts.montserratAlternates(
              fontSize: 60,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
          )
        ],
      ),
    );
  }
}