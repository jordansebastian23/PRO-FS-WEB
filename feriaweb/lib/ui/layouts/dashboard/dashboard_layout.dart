import 'package:feriaweb/providers/sidemenu_provider.dart';
import 'package:feriaweb/ui/shared/navbar.dart';
import 'package:feriaweb/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SidemenuProvider.menuController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
        body: Stack(
      children: [
        Row(children: [
          //TODO: esto depende si es mas de 700px
          if (size.width >= 700) SideBar(),

          Expanded(
            child: Column(
              children: [
                if (size.width < 700)
                Navbar(),

                //Contenido
                Expanded(child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: widget.child,
                )),
              ],
            ),
          )
        ]),
        if (size.width < 700)
          AnimatedBuilder(
              animation: SidemenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [

                  if (SidemenuProvider.isOpen)
                    AnimatedOpacity(
                      opacity: SidemenuProvider.opacity.value,
                      duration: Duration(milliseconds: 250),
                      child: GestureDetector(
                        onTap: () => SidemenuProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),


                  Transform.translate(offset:
                  Offset(SidemenuProvider.movement.value, 0),
                  child: SideBar()),
                    




                  ]))
      ],
    ));
  }
}
