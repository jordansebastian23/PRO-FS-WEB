import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/providers/auth_provider.dart';
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
            text: 'Dashboard',
            icon: Icons.home_outlined,
            isActive: sidemenuProvider.currentPage == Flurorouter.dashboardRoute,
            onPressed: () {
                navigateTo(Flurorouter.dashboardRoute);
              }
          ),
          MenuItem(
              text: 'Administrar Usuarios',
              icon: Icons.person_outlined,
              isActive: sidemenuProvider.currentPage == Flurorouter.gUsuariosRoute,
              onPressed: () {
                navigateTo(Flurorouter.gUsuariosRoute);
              }),
          MenuItem(
              text: 'Pagos Realizados',
              icon: Icons.attach_money_outlined,
              isActive: sidemenuProvider.currentPage == Flurorouter.pRealizadosRoute,
              onPressed: () {
                navigateTo(Flurorouter.pRealizadosRoute);
              }),
          MenuItem(
              text: 'Archivos Subidos',
              icon: Icons.edit_document,
              isActive: sidemenuProvider.currentPage == Flurorouter.aSubidosRoute,
              onPressed: () {
                navigateTo(Flurorouter.aSubidosRoute);
              }),
          MenuItem(
              text: 'Gestionar Cargas',
              icon: Icons.view_in_ar_outlined,
              isActive: sidemenuProvider.currentPage == Flurorouter.gCargasRoute,
              onPressed: () {
                navigateTo(Flurorouter.gCargasRoute);
              }),
          MenuItem(
              text: 'Historial de Tramites',
              icon: Icons.calendar_month_outlined,
              isActive: sidemenuProvider.currentPage == Flurorouter.hTramitesRoute,
              onPressed: () {
                //TODO: Realizar lo mismo para todos
                navigateTo(Flurorouter.hTramitesRoute);
              }),
          SizedBox(height: 30),
          TextSeparator(text: 'Opciones'),
          MenuItem(
              text: 'Notificaciones',
              icon: Icons.notifications_outlined,
              isActive: sidemenuProvider.currentPage == Flurorouter.notifyRouteAdm,
              onPressed: () {
                navigateTo(Flurorouter.notifyRouteAdm);
              }),
          SizedBox(height: 50),
          TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Logout',
              icon: Icons.logout_outlined,
              isActive: false,
              onPressed: () {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                authProvider.logout().then((_) {
                  navigateTo(Flurorouter.loginRoute);
                });
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      BoxDecoration(color: CustomColor.background,
      borderRadius: BorderRadius.only(topRight: Radius.circular(25), ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 26,
        )
      ]);
}
