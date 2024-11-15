


import 'package:flutter/material.dart';

class NavigationService {

  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static navigateTo( String routeName ) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static replaceTo( String routeName ) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  // Mostrar error en un snackbar
  static void showErrorSnackbar(String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

}
