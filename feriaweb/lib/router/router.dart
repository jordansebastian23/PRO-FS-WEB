import 'package:feriaweb/router/dashboard_handlers.dart';
import 'package:feriaweb/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:feriaweb/router/admin_handlers.dart';

class Flurorouter {

  static final FluroRouter router = new FluroRouter();

  static String rootRoute     = '/';

  // Auth Router
  static String loginRoute    = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard Menu
  //TODO: CREAR RUTAS PARA LOS DIFERENTES PANELES DE CONTROL
  static String dashboardRoute = '/dashboard';
  static String gUsuariosRoute = '/dashboard/gestion-usuarios';
  static String pRealizadosRoute = '/dashboard/pagos-pendientes';
  static String aSubidosRoute = '/dashboard/archivos-subidos';
  static String hTramitesRoute = '/dashboard/historial-tramites';
  static String gCargasRoute = '/dashboard/gestion-cargas';

  //Dashboard opciones
  static String notifyRoute = '/dashboard/notificaciones';
  static String notifyRouteAdm = '/admin/notificaciones';
  static String configRoute = '/dashboard/ajustes';
  //logout
  static String logoutRoute = '/Dashboard/logout';




  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none );
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none );

    // Dashboard
    //TODO: CREAR RUTAS PARA LOS DIFERENTES PANELES DE CONTROL
    router.define(dashboardRoute, handler: DashboardHandlers.dashboard, transitionType: TransitionType.none );
    router.define(pRealizadosRoute, handler: DashboardHandlers.pRealizados, transitionType: TransitionType.none );
    router.define(aSubidosRoute, handler: DashboardHandlers.aSubidos, transitionType: TransitionType.none );
    router.define(hTramitesRoute, handler: DashboardHandlers.hTramites, transitionType: TransitionType.none );
    router.define(gCargasRoute, handler: DashboardHandlers.gCargas, transitionType: TransitionType.none );
    router.define(notifyRoute, handler: DashboardHandlers.notify, transitionType: TransitionType.none );
    router.define(configRoute, handler: DashboardHandlers.config, transitionType: TransitionType.none );
    router.define(gUsuariosRoute, handler: DashboardHandlers.gUsuarios, transitionType: TransitionType.none );

    //adm dashboard
    router.define(notifyRouteAdm, handler: DashboardHandlers.notifyadm, transitionType: TransitionType.none );

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;

  }
  


}

