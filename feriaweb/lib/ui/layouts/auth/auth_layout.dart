import 'package:feriaweb/ui/layouts/auth/widgets/background_logiquick.dart';
import 'package:feriaweb/ui/layouts/auth/widgets/custom_title.dart';
import 'package:flutter/material.dart';




class AuthLayout extends StatelessWidget {

  final Widget child;

  const AuthLayout({
    Key? key, 
    required this.child
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Scrollbar(
        // isAlwaysShown: true,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [

            ( size.width > 1000 )
              ? _DesktopBody( child: child)
              : _MobileBody( child: child ),
            
          ],
        ),
      )
    );
  }
}


class _MobileBody extends StatelessWidget {

  final Widget child;

  const _MobileBody({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox( height: 20 ),
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 500,
            child: child,
          ),

          Container(
            width: double.infinity,
            height: 400,
            child: BackgroundLogiQuick(),
          )
        ],
      ),
    );
  }
}


class _DesktopBody extends StatelessWidget {

  final Widget child;

  const _DesktopBody({
    Key? key, 
    required this.child
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height ,
      color: Colors.black,
      child: Row(
        children: [

          // Logi Background
          Expanded(
            child: BackgroundLogiQuick()),
          

          // View Container
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox( height: 100 ),
                CustomTitle(),
                SizedBox( height: 50 ),
                Expanded(child: child ),
              ],
            ),
          )

        ],
      ),
    );
  }
}