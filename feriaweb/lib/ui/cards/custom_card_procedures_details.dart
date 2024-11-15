import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardProceduresDetails extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final String title;
  final String subTitle;
  final bool showButtons;


  const CustomCardProceduresDetails({super.key,
  required this.icon,
  required this.bgColor,
  required this.title,
  required this.subTitle,
  this.showButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: bgColor,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.inter(color: Colors.black, fontSize: 14 , fontWeight: FontWeight.w600)),
            Text(subTitle, style: GoogleFonts.inter(color: Colors.grey, fontSize: 14 , fontWeight: FontWeight.w400)),
          ],
        ),
        Spacer(),
        if (showButtons) ...[
        SizedBox(
          width: 73,
          height: 16,
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.amber)),
              onPressed: () {},
              child: Text('Revisar', style: TextStyle(fontSize: 12, color: Colors.white))),
        ),
        SizedBox(width: 10),
        Column(
          children: [
            SizedBox(
              width: 73,
              height: 16,
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.redAccent)),
                  child: Text('Denegar', style: TextStyle(fontSize: 12, color: Colors.white))),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: 73,
              height: 16,
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(CustomColor.buttons)),
                  child: Text('Notificar', style: TextStyle(fontSize: 12, color: Colors.white))),
            ),
          ],
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 73,
          height: 16,
          child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.greenAccent)),
              child: Text('Aprobar', style: TextStyle(fontSize: 12, color: Colors.white))),
        )
      ],
      ],
    );
  }
}
