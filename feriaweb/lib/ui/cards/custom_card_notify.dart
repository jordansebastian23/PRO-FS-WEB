import 'package:flutter/material.dart';

class CustomCardNotify extends StatefulWidget {
  CustomCardNotify(
      {super.key,
      required this.title,
      required this.icon,
      required this.state,
      required this.textRadio,
      required this.colorBorder, required this.colorIcon, required this.value, required this.groupValue, required this.onChanged});

  final String title;
  final IconData icon;
  final Color colorIcon;
  final String state;
  final String textRadio;
  final Color colorBorder;
    final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  @override
  State<CustomCardNotify> createState() => _CustomCardNotifyState();
}

class _CustomCardNotifyState extends State<CustomCardNotify> {
  final TextEditingController _notificationController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: 300,
          height: 188,
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
            color: widget.colorBorder, width: 8),
            right: BorderSide(
            color: widget.colorBorder, width: 1),
            top: BorderSide(
            color: widget.colorBorder, width: 1),
            bottom: BorderSide(
            color: widget.colorBorder, width: 1),
          )
      ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: widget.colorIcon, size: 24),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      )),
                  Text(widget.state),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    width: 230,
                    child: TextFormField(
                      controller: _notificationController,
                      maxLines: 5, // Permite múltiples líneas
                      decoration: InputDecoration(
                        hintText: '(Escriba aquí su mensaje)',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        //seleccion de notificacion
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              activeColor: Color(0xff0958D9),
              value: widget.value,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
            ),
            Text(widget.textRadio),
          ],
        ),
      ],
    );
  }
}
