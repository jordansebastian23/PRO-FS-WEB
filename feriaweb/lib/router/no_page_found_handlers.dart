import 'package:feriaweb/providers/sidemenu_provider.dart';
import 'package:fluro/fluro.dart';
import 'package:feriaweb/ui/views/no_page_found_view.dart';
import 'package:provider/provider.dart';

class NoPageFoundHandlers {

  static Handler noPageFound = Handler(
    handlerFunc: ( context, params ) {

      Provider.of<SidemenuProvider>(context!, listen: false).setCurrentPageUrl('/404');
      return NoPageFoundView();
    }
  );


}

