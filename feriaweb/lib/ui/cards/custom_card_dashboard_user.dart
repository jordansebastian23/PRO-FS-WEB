import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomCardUser extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color colorCircle;

  const CustomCardUser({super.key,
  required this.title,
  required this.value,
  required this.icon,
  required this.colorCircle});

  @override
  Widget build(BuildContext context) {
    return  Container(
                width: 310,
                height: 150,
                padding: EdgeInsets.all(24),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: colorCircle,
                          child: Icon(icon, size: 40, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(value, style: GoogleFonts.barlow(fontSize: 46, fontWeight: FontWeight.bold)),
                            Text(title, style: GoogleFonts.barlow(fontSize: 16, fontWeight: FontWeight.w400)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
  }
}