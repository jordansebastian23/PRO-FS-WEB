import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:flutter/material.dart';


class CustomCardArchives extends StatelessWidget {
  final String title;
  final String time;
  final String size;
  final IconData icon;
  final bool IsCorrect;

  const CustomCardArchives({super.key, required this.title, required this.time, required this.size, required this.icon, required this.IsCorrect});

  @override
  Widget build(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(icon, size: 16,),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                        )),

                        SizedBox(height: 2),
                        Text(
                          IsCorrect ? time : 'Error - No se ha subido el archivo correctamente',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                        )),
                      ],
                    ),
                    Spacer(),
                    if (!IsCorrect) ...[
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: CustomColor.buttons,
                          side: BorderSide(color: CustomColor.buttons, width: 1),
                        ),
                        onPressed: (){},
                        child: Text('Notificar', style: TextStyle(color: Colors.white))),

                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          // Lógica para recargar el archivo
                        },
                        icon: Icon(Icons.refresh, color: Colors.red, size: 16,),
                      ),
                    ],
                    Container(
                      height: 20,
                      width: 56,
                      decoration: BoxDecoration(
                        color: IsCorrect ? Colors.grey[300] : Colors.red[300],
                        borderRadius: BorderRadius.circular(5

                        )
                      ),
                      child:Text(
                        IsCorrect ? size : 'Error',
                            textAlign: TextAlign.center),
                    ),
                    
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.more_vert)
                    )
                  ],
                );
  }
}