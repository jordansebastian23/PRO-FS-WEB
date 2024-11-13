import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardProceduresDetails extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final String title;
  final String subTitle;
  final bool showButtons;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onReview;

  const CustomCardProceduresDetails({
    required this.icon,
    required this.bgColor,
    required this.title,
    required this.subTitle,
    this.showButtons = false,
    this.onApprove,
    this.onReject,
    this.onReview,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
            Text(subTitle, style: TextStyle(color: Colors.grey)),
          ],
        ),
        Spacer(),
        if (showButtons) ...[
          TextButton(
            onPressed: onReview,
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.amber)),
            child: Text('Revisar', style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
          TextButton(
            onPressed: onReject,
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.redAccent)),
            child: Text('Denegar', style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
          TextButton(
            onPressed: onApprove,
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.greenAccent)),
            child: Text('Aprobar', style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
        ],
      ],
    );
  }
}