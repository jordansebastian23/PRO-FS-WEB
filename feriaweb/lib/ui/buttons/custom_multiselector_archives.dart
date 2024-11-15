import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomMultiSelectorArchives extends StatefulWidget {
  const CustomMultiSelectorArchives({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.selectedValues,
    required this.onChanged,
  });

  final String title;
  final String subTitle;
  final int value;
  final List<int> selectedValues;
  final ValueChanged<List<int>> onChanged;

  @override
  State<CustomMultiSelectorArchives> createState() => _CustomMultiSelectorArchivesState();
}

class _CustomMultiSelectorArchivesState extends State<CustomMultiSelectorArchives> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedValues.contains(widget.value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: CustomColor.buttons,
          value: isSelected,
          onChanged: (bool? newValue) {
            setState(() {
              if (newValue == true) {
                widget.selectedValues.add(widget.value);
              } else {
                widget.selectedValues.remove(widget.value);
              }
              widget.onChanged(widget.selectedValues);
            });
          },
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
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            Text(
              widget.subTitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            )
          ],
        ),
      ],
    );
  }
}