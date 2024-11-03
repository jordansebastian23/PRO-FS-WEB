import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/providers/sidemenu_provider.dart';
import 'package:feriaweb/router/router.dart';
import 'package:feriaweb/services/navigation_service.dart';
import 'package:feriaweb/ui/shared/widgets/logo.dart';
import 'package:feriaweb/ui/shared/widgets/menu_item.dart';
import 'package:feriaweb/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SidemenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sidemenuProvider = Provider.of<SidemenuProvider>(context);
    return Container(
      width: 244,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Logo(),
          SizedBox(height: 50),
          TextSeparator(text: 'Menu'),
          MenuItem(
              text: 'Panel de control',
              icon: Icons.home,
              isActive: sidemenuProvider.currentPage == Flurorouter.dashboardRoute,
              onPressed: () {
                navigateTo(Flurorouter.dashboardRoute);
              }),
          MenuItem(
              text: 'Pagos Pendientes',
              icon: Icons.attach_money_outlined,
              isActive: sidemenuProvider.currentPage == Flurorouter.pPendientesRoute,
              onPressed: () {
                navigateTo(Flurorouter.pPendientesRoute);
              }),
          MenuItem(
              text: 'Archivos Pendientes',
              icon: Icons.edit_document,
              isActive: false,
              onPressed: () {
                navigateTo(Flurorouter.pPendientesRoute);
              }),
          MenuItem(
              text: 'Historial de Tramites',
              icon: Icons.calendar_month_outlined,
              isActive: false,
              onPressed: () {
                //TODO: Realizar lo mismo para todos
                navigateTo(Flurorouter.pPendientesRoute);
              }),
          SizedBox(height: 30),
          TextSeparator(text: 'Opciones'),
          MenuItem(
              text: 'Notificaciones',
              icon: Icons.notifications_outlined,
              isActive: false,
              onPressed: () {
                navigateTo(Flurorouter.pPendientesRoute);
              }),
          MenuItem(
              text: 'Ajustes',
              icon: Icons.settings,
              isActive: false,
              onPressed: () {
                navigateTo(Flurorouter.pPendientesRoute);
              }),
          SizedBox(height: 50),
          TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Logout',
              icon: Icons.logout_outlined,
              isActive: false,
              onPressed: () {
                navigateTo(Flurorouter.pPendientesRoute);
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      BoxDecoration(color: CustomColor.background, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 26,
        )
      ]);
}
