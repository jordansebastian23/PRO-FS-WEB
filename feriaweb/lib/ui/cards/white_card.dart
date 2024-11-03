import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget child;
  final double? width;

  const WhiteCard({super.key,
  this.title,
  required this.child,
  this.icon,
  this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width : null,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) 
          ...[
            Row(
              children: [
                if (icon != null)
                  Icon(icon),
                SizedBox(width: 20,),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(title!,
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Divider(
              thickness: 3,
              indent: 10,
              endIndent: 10,
              color: Colors.black,
            ),
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 5,
                offset: Offset(0, 5))
          ]);
}
