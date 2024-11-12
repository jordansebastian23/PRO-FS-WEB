import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioSelectArchives extends StatefulWidget {
  const CustomRadioSelectArchives({super.key, required this.title, required this.subTitle, required this.value, required this.groupValue, required this.onChanged});


  final String title;
  final String subTitle;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  @override
  State<CustomRadioSelectArchives> createState() => _CustomRadioSelectArchivesState();
}

class _CustomRadioSelectArchivesState extends State<CustomRadioSelectArchives> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          activeColor: CustomColor.buttons,
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
        ),
        SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundColor: CustomColor.buttons,
          child: Icon(
            Icons.description_outlined,
            color: Colors.white,
            size: 10,
          ),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: widget.value == widget.groupValue ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            Text(
              widget.subTitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: widget.value == widget.groupValue ? FontWeight.w500 : FontWeight.w400,
              ),
            )
          ],
        ),
      ],
    );
  }
}
