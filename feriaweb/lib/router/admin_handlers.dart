import 'package:feriaweb/ui/views/admin/dashboard_view.dart';
import 'package:fluro/fluro.dart';
import 'package:feriaweb/ui/views/login_view.dart';
import 'package:feriaweb/ui/views/register_view.dart';
import 'package:feriaweb/services/session_manager.dart';

class AdminHandlers {
  static Handler login = Handler(
    handlerFunc: (context, params) {
      final isAuth = SessionManager.getAuthStatusSync();
      return isAuth ? DashboardView() : LoginView();
    },
  );

  static Handler register = Handler(
    handlerFunc: (context, params) {
      final isAuth = SessionManager.getAuthStatusSync();
      return isAuth ? DashboardView() : RegisterView();
    },
  );
}