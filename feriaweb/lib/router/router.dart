import 'package:feriaweb/router/admin_handlers.dart';
import 'package:feriaweb/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  static String rootRoute = '/auth/login';

  //auth routes
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  //dashboard routes
  static String dashboardRoute = '/dashboard';

  static void configureRoutes() {
    //auth routes
    router.define(loginRoute, handler: AdminHandlers.login);
    router.define(rootRoute, handler: AdminHandlers.login);
    
    //Por hacer
    // router.define(loginRoute, handler: handler);

    //404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;


  }
}
