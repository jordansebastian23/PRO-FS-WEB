import 'package:feriaweb/ui/views/admin/dashboard_view.dart';
import 'package:feriaweb/ui/views/admin/nofity_adm_view.dart';
import 'package:feriaweb/ui/views/agent/Payment_success.dart';
import 'package:feriaweb/ui/views/agent/archives_uppload.dart';
import 'package:feriaweb/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:feriaweb/services/session_manager.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(
    handlerFunc: (context, params)  {
      final isAuth =  SessionManager.getAuthStatusSync();
      return isAuth ? DashboardView() : LoginView();
    },
  );

  static Handler pRealizados = Handler(
    handlerFunc: (context, params)  {
      final isAuth =  SessionManager.getAuthStatusSync();
      return isAuth ? PaymentsSuccess() : LoginView();
    },
  );

  static Handler aSubidos = Handler(
    handlerFunc: (context, params)  {
      final isAuth =  SessionManager.getAuthStatusSync();
      return isAuth ? ArchivesUppload() : LoginView();
    },
  );

  static Handler hTramites = Handler(
    handlerFunc: (context, params)  {
      final isAuth =  SessionManager.getAuthStatusSync();
      return isAuth ? PaymentsSuccess() : LoginView();
    },
  );

  static Handler notify = Handler(
    handlerFunc: (context, params)  {
      final isAuth =  SessionManager.getAuthStatusSync();
      return isAuth ? PaymentsSuccess() : LoginView();
    },
  );

  static Handler notifyadm = Handler(
    handlerFunc: (context, params)  {
      final isAuth =  SessionManager.getAuthStatusSync();
      return isAuth ? NofityAdmView() : LoginView();
    },
  );

  static Handler config = Handler(
    handlerFunc: (context, params)  {
      final isAuth =  SessionManager.getAuthStatusSync();
      return isAuth ? PaymentsSuccess() : LoginView();
    },
  );
}
