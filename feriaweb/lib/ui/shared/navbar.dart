import 'package:feriaweb/providers/sidemenu_provider.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 60,
      decoration: _buildBoxDecoration(),
      child: Row(
        children: [
          if ( size.width <= 700 )
          IconButton(
            icon: Icon( Icons.menu_outlined),
            onPressed: (){
              SidemenuProvider.openMenu();
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 5
      )
    ]



  );
  
  
}