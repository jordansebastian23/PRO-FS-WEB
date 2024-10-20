import 'package:feriaweb/ui/views/login_view.dart';
import 'package:feriaweb/ui/views/register_view.dart';
import 'package:fluro/fluro.dart';

class AdminHandlers {

  static Handler login = Handler(
    handlerFunc: (context, params) {
      return LoginView();
    },
  );


    static Handler register = Handler(
    handlerFunc: (context, params) {
      return RegisterView();
    },
  );







}