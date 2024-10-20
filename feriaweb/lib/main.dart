import 'package:feriaweb/router/router.dart';
import 'package:feriaweb/ui/layouts/auth/auth_layout.dart';
import 'package:flutter/material.dart';

void main() {
  Flurorouter.configureRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogiQuick | Proyecto Feria',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      builder: ( _ , child) {
        
        return AuthLayout( child: child! );

      },
      //EDITAR BARRA SCROLL
      theme: ThemeData.light().copyWith(
        scrollbarTheme: ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(Colors.grey[500])
        )
      ),
    );
    // initialRoute: Flurorouter.rootRoute);
  }
}
