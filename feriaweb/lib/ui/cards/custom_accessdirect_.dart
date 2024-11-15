import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAccessDirect extends StatelessWidget {
  final String title;
  final String button;
  final String ruta;
  const CustomAccessDirect({super.key, required this.title, required this.button, required this.ruta});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(title,
              style: GoogleFonts.barlow(
                  fontSize: 18, fontWeight: FontWeight.w500)),
          Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(CustomColor.buttons),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ruta);
            },
            child: Text(button,
                style: GoogleFonts.barlow(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
