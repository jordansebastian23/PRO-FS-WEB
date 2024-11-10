import 'package:feriaweb/providers/auth_provider.dart';
import 'package:feriaweb/ui/views/agent/dashboard_view.dart';
import 'package:feriaweb/ui/views/login_view.dart';
import 'package:feriaweb/ui/views/register_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);

      return authProvider.authStatus == AuthStatus.authenticated
          ? DashboardView()
          : LoginView();
    },
  );

  static Handler register = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);

      return authProvider.authStatus == AuthStatus.authenticated
          ? DashboardView()
          : RegisterView();
    },
  );
}
