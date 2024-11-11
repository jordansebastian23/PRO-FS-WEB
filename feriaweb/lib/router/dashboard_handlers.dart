import 'package:feriaweb/providers/sidemenu_provider.dart';
import 'package:feriaweb/router/router.dart';
import 'package:feriaweb/ui/views/agent/carga_view.dart';
import 'package:feriaweb/ui/views/agent/history_.dart';
import 'package:feriaweb/ui/views/agent/nofity_view.dart';
import 'package:feriaweb/ui/views/agent/Payment_success.dart';
import 'package:feriaweb/ui/views/agent/archives_uppload.dart';
import 'package:feriaweb/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:feriaweb/providers/auth_provider.dart';
import 'package:feriaweb/ui/views/agent/dashboard_view.dart';

class DashboardHandlers {

  static Handler dashboard = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.dashboardRoute);
      if ( authProvider.authStatus == AuthStatus.authenticated )
        return DashboardView();
      else 
        return LoginView();
    }
  );
  
  
  static Handler pRealizados = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.pRealizadosRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return PaymentsSuccess();
      else 
        return LoginView();
    }
  );

  //TODO: ASIGNAR LA VISTA

  static Handler aSubidos = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.aSubidosRoute);

      if ( authProvider.authStatus == AuthStatus.authenticated )
        return ArchivesUppload();
      else 
        return LoginView();
    }
  );

  static Handler hTramites = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.hTramitesRoute);
      if ( authProvider.authStatus == AuthStatus.authenticated )
        return HistoryTramites();
      else 
        return LoginView();
    }
  );

    static Handler notify = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.pRealizadosRoute);
      if ( authProvider.authStatus == AuthStatus.authenticated )
        return PaymentsSuccess();
      else 
        return LoginView();
    }
  );

  static Handler notifyadm = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.notifyRouteAdm);
      if ( authProvider.authStatus == AuthStatus.authenticated )
        return NofityView();
      else 
        return LoginView();
    }
  );


  static Handler config = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.pRealizadosRoute);
      if ( authProvider.authStatus == AuthStatus.authenticated )
        return PaymentsSuccess();
      else 
        return LoginView();
    }
  );

  static Handler gCargas = Handler(
    handlerFunc: ( context, params ) {

      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SidemenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.gCargasRoute);
      if ( authProvider.authStatus == AuthStatus.authenticated )
        return CargaView();
      else 
        return LoginView();
    }
  );

}

