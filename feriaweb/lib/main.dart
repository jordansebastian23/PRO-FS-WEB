import 'package:feriaweb/providers/auth_provider.dart';
import 'package:feriaweb/providers/sidemenu_provider.dart';
import 'package:feriaweb/services/session_manager.dart';
import 'package:feriaweb/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:feriaweb/ui/layouts/splash/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:feriaweb/router/router.dart';

import 'package:feriaweb/services/navigation_service.dart';

import 'package:feriaweb/ui/layouts/auth/auth_layout.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBSuZfaGBbwRy7l-kghlCvgg-3Gm8sy-RE",
        authDomain: "logiquick-e933b.firebaseapp.com",
        projectId: "logiquick-e933b",
        storageBucket: "logiquick-e933b.firebasestorage.app",
        messagingSenderId: "642056532071",
        appId: "1:642056532071:web:061233d55f6fbad49ea4c2",
        measurementId: "G-CWWQQZCZQR"),
  );
  await SessionManager.initializeAuthStatus();
  Flurorouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => AuthProvider(),
        ),
        // Ensure at least one provider is added, replace AuthProvider if needed
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => SidemenuProvider(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // Logging to confirm rebuilds
    print("Current authStatus: ${authProvider.authStatus}");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      builder: (_, child) {
        if (authProvider.authStatus == AuthStatus.checking) {
          return SplashLayout();
        } else if (authProvider.authStatus == AuthStatus.authenticated) {
          print('Calling DashboardLayout');
          return DashboardLayout(child: child!);
        } else {
          print('Calling AuthLayout');
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(
                  Colors.grey.withOpacity(0.5)))),
    );
  }
}

Future<bool> isAuthenticated() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') != null;
}
