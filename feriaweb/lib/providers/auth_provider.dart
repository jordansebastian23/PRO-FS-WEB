import 'package:feriaweb/router/router.dart';
import 'package:feriaweb/services/google_auth.dart';
import 'package:feriaweb/services/local_login.dart';
import 'package:feriaweb/services/navigation_service.dart';
import 'package:feriaweb/services/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('token'));
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
    } else {
      authStatus = AuthStatus.authenticated;
    }
    print('AuthStatus -> $authStatus');
    notifyListeners();
  }

  Future<void> loginWithCredentials(String email, String password) async {
    await LoginService.loginUser(
      email: email,
      password: password,
      onSuccess: () async {
        final token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('token'));
        if (token != null) {
          await SessionManager.login(token);
          _token = token;
          authStatus = AuthStatus.authenticated;
          notifyListeners();
          print('Navigating to dashboard');
          NavigationService.replaceTo(Flurorouter.dashboardRoute);
        } else {
          authStatus = AuthStatus.notAuthenticated; 
          notifyListeners();

        }
      },
      onError: (error) {
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
        NavigationService.showErrorSnackbar(error);  // Show the error message
      },
    );
  }

  Future<void> loginWithGoogle() async {
    final googleAuth = AutenticacionGoogle();
    await googleAuth.autentificaciongoogle(
      onSuccess: () async {
        final token = await SharedPreferences.getInstance().then((prefs) => prefs.getString('token'));
        if (token != null) {
          await SessionManager.login(token);
          _token = token;
          authStatus = AuthStatus.authenticated;
          notifyListeners();
          print('Navigating to dashboard');
          NavigationService.replaceTo(Flurorouter.dashboardRoute);
        }
      },
      onError: (error) {
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
        print("Login failed: $error");
        NavigationService.showErrorSnackbar(error);  // Show the error message
      },
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final loginType = prefs.getString('loginType');

    // Log out based on login type
    if (loginType == 'google') {
      final googleAuth = AutenticacionGoogle();
      await googleAuth.logoutGoogleUser();
    } else if (loginType == 'credentials') {
      await LoginService.logoutCredentialsUser();
    }

    // Clear session in SessionManager
    await SessionManager.logout();

    // Update auth status
    authStatus = AuthStatus.notAuthenticated;
    _token = null;
    notifyListeners();
    NavigationService.replaceTo(Flurorouter.loginRoute);
  }
}
