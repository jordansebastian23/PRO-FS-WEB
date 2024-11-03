import 'package:feriaweb/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatefulWidget {

  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  const MenuItem({
    Key? key, 
    required this.text, 
    required this.icon, 
    this.isActive = false, 
    required this.onPressed
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      color: isHover ? Colors.white.withOpacity(0.1)
      : widget.isActive ? CustomColor.buttons : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: EdgeInsets.symmetric( vertical: 10, horizontal: 30),
            child: MouseRegion(
              onEnter: ( _ ) => setState(() => isHover = true),
              onExit: ( _ ) => setState(() => isHover = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon( widget.icon, color: widget.isActive ? Colors.black: Colors.white),
                  SizedBox( width: 10),
                  Text( widget.text, style: GoogleFonts.roboto( color: widget.isActive ? Colors.black:Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)
                  )
                ],
              ),
            ),
            ),
        ),
      ),
      
      );
  }
}