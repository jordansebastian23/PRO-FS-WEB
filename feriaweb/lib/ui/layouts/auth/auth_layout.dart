import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/layouts/auth/widgets/background_sitrans.dart';
import 'package:feriaweb/ui/layouts/auth/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Scrollbar(
          
          child: ListView
          (physics: ClampingScrollPhysics(),
          children: [
                (size.width > 1000)
            //Desktop
            ? _DesktopBody(child: child)
            //mobile
            : _MobileBody(child: child),
          
                //LinksBar
              ]),
        ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 500,
            color: CustomColor.background,
            child: child,
          ),
          Container(
            width: double.infinity,
            height: 400,
            child: BackgroundSitrans(),
          )
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

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
            height: double.infinity,
            color: CustomColor.background,
            child: Column(
              children: [
                SizedBox(height: 20),
                //CSizedBox( height: 20 ),
                CustomTitle(),
                SizedBox(height: 50),
                Expanded(child: child)
              ],
            ),
          )
        ],
      ),
    );
  }
}
