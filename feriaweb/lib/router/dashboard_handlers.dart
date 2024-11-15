import 'package:feriaweb/providers/auth_provider.dart';
import 'package:feriaweb/providers/sidemenu_provider.dart';
import 'package:feriaweb/router/router.dart';
import 'package:feriaweb/ui/views/agent/dashboard_view.dart';
import 'package:feriaweb/ui/views/agent/carga_view.dart';
import 'package:feriaweb/ui/views/agent/dashboard_view.dart';
import 'package:feriaweb/ui/views/agent/history_procedures.dart';
import 'package:feriaweb/ui/views/agent/nofity_view.dart';
import 'package:feriaweb/ui/views/agent/Payment_success.dart';
import 'package:feriaweb/ui/views/agent/archives_uppload.dart';
import 'package:feriaweb/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:feriaweb/providers/auth_provider.dart';
import 'package:feriaweb/ui/views/agent/user_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.dashboardRoute);
      
      return authProvider.authStatus == AuthStatus.authenticated
          ? DashboardView()
          : LoginView();
    },
  );
  
  static Handler gUsuarios = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.gUsuariosRoute);
      if ( authProvider.authStatus == AuthStatus.authenticated )
        return CreateUserView();
      else 
        return LoginView();
    }
  );

  static Handler pRealizados = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.pRealizadosRoute);

      return authProvider.authStatus == AuthStatus.authenticated
          ? PaymentsSuccess()
          : LoginView();
    },
  );

  static Handler aSubidos = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.aSubidosRoute);

      return authProvider.authStatus == AuthStatus.authenticated
          ? ArchivesUppload()
          : LoginView();
    },
  );

  static Handler hTramites = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.hTramitesRoute);

      return authProvider.authStatus == AuthStatus.authenticated
          ? HistoryTramites()
          : LoginView();
    },
  );

  static Handler notify = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.notifyRoute);

      return authProvider.authStatus == AuthStatus.authenticated
          ? PaymentsSuccess()
          : LoginView();
    },
  );

  static Handler notifyadm = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.notifyRouteAdm);

      return authProvider.authStatus == AuthStatus.authenticated
          ? NofityView()
          : LoginView();
    },
  );

  static Handler config = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.configRoute);

      return authProvider.authStatus == AuthStatus.authenticated
          ? PaymentsSuccess()
          : LoginView();
    },
  );

  static Handler gCargas = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.gCargasRoute);
      return authProvider.authStatus == AuthStatus.authenticated
          ? CargaView()
          : LoginView();
    },
  );

}
