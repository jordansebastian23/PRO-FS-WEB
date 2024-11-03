import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
            ),
            Image.asset('assets/logiquick-logo.png', width: 40)]),
          SizedBox(width: 10),
          Text('LogiQuick', style: GoogleFonts.montserratAlternates(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}