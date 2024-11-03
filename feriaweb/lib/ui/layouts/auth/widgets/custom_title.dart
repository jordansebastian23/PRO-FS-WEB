import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 75,
              ),  
              Image.asset(
                'logiquick-logo.png',
                width: 150,
                height: 150,
              ),
            ],
          ),

          SizedBox( height: 20 ),

          FittedBox(
            fit: BoxFit.contain,
            child: RichText(
              text: TextSpan(
                text: 'Logi', style: GoogleFonts.montserratAlternates(
                fontSize: 60,
                color: CustomColor.buttons,
                fontWeight: FontWeight.bold
              ),
              children: [TextSpan(
                text: 'Quick', style: GoogleFonts.montserratAlternates(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              )
              
        ]
            ),
            
          )
        )
        ]
      ),
    );
  }
}