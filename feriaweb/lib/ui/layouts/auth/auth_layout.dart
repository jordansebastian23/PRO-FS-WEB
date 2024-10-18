import 'package:feriaweb/ui/layouts/auth/widgets/background_sitrans.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
        //Desktop
        _DesktopBody(),
        //mobile

        //LinksBar
]
      )
    );
  }
}



class _DesktopBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //es necesario por el listview
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: Row(
        //Background
        children: [
          BackgroundSitrans(),

          Container(
            width: 600,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}