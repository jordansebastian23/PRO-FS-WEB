

//  import 'package:feriaweb/router/router.dart';
//  import 'package:feriaweb/services/local_storage.dart';
//  import 'package:feriaweb/services/navigation_service.dart';
import 'package:feriaweb/services/google_auth.dart';
import 'package:feriaweb/services/local_login.dart';
import 'package:feriaweb/services/session_manager.dart';
import 'package:flutter/material.dart';
 
 enum AuthStatus {
   checking,
   authenticated,
   notAuthenticated
 }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isAuthenticated = await SessionManager.getAuthStatusSync();
    authStatus = isAuthenticated ? AuthStatus.authenticated : AuthStatus.notAuthenticated;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    final googleAuth = AutenticacionGoogle();
    await googleAuth.autentificaciongoogle(
      onSuccess: () {
        authStatus = AuthStatus.authenticated;
        notifyListeners();
      },
      onError: (error) {
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
      },
    );
  }

  Future<void> loginWithCredentials(String email, String password) async {
    await LoginService.loginUser(
      email: email,
      password: password,
      onSuccess: () {
        authStatus = AuthStatus.authenticated;
        notifyListeners();
      },
      onError: (error) {
        authStatus = AuthStatus.notAuthenticated;
        notifyListeners();
      },
    );
  }

  Future<void> logout() async {
    await SessionManager.logout();
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
