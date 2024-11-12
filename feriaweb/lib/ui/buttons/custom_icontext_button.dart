import 'package:flutter/material.dart';

class CustomIcontextButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const CustomIcontextButton({super.key,
  required this.title,
  required this.icon,
  required this.onPressed, required this.color});

  @override
  State<CustomIcontextButton> createState() => _CustomIcontextButtonState();
}

class _CustomIcontextButtonState extends State<CustomIcontextButton> {

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        widget.onPressed();
        
      },
      label: Text(
        widget.title,
        style: TextStyle(fontSize: 14, color: widget.color),
      ),
      icon: Icon(widget.icon, size: 20, color: widget.color,),
    );
  }
}
