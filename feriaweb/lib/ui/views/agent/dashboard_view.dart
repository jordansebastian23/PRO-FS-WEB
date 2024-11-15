import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/ui/cards/custom_accessdirect_.dart';
import 'package:feriaweb/ui/cards/custom_card_dashboard_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      padding: EdgeInsets.only(top: 50, right: 24, left: 24),
      width: 1000,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard', style: GoogleFonts.barlow(fontSize: 32, fontWeight: FontWeight.w600)),
          SizedBox(height: 5,),
          Text('Hola, \$User. ¡Bienvenidos de nuevo al panel de LogiQuick!', style: GoogleFonts.barlow(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 15,),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CustomCardUser(
              title: 'Total Usuarios',
              value: '10',
              icon: Icons.person_outline,
colorCircle: Color(0xff004080),            ),         
            CustomCardUser(
              title: 'Usuarios Deshabilitados',
              value: '10',
              icon: Icons.person_off_outlined,
              colorCircle: Color(0xFFE74C3C),
            ), CustomCardUser(
              title: 'Usuarios Activos',
              value: '10',
              icon: Icons.person_outline,
colorCircle: Color(0xff004080),            ),         
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CustomCardUser(
              title: 'Tramites Pendientes',
              value: '10',
              icon: Icons.content_paste,
              colorCircle: Color(0xffBDC3C7),
            ),
            CustomCardUser(
              title: 'Documentos Subidos',
              value: '10',
              icon: Icons.upload_file,
              colorCircle: Color(0xffF39C12),
            ), CustomCardUser(
              title: 'Trámites Completados',
              value: '10',
              icon: Icons.check_box_outlined,
              colorCircle: Color(0xff27AE60),
            ),         
            ],
          ),
          SizedBox(height: 20),
          Text('Accesos rapidos', style: GoogleFonts.barlow(fontSize: 24, fontWeight: FontWeight.w600)),
          SizedBox(height: 20),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomAccessDirect(
              title: 'Administrar Usuarios',
              button: 'Ver Usuarios',
              ruta: '/dashboard/gestion-usuarios',
              ),
              CustomAccessDirect(
              title: 'Administrar Pagos',
              button: 'Gestionar Pagos',
              ruta: '/dashboard/pagos-pendientes',
              ),
              CustomAccessDirect(
              title: 'Administrar Archivos',
              button: 'Gestionar Archivos',
              ruta: '/dashboard/archivos-subidos',
              ),
              CustomAccessDirect(
              title: 'Administrar Cargas',
              button: 'Gestionar Cargas',
              ruta: '/dashboard/gestion-cargas',
              ),
              CustomAccessDirect(
                title:'Enviar notificacion',
                button: 'Enviar notificacion',
                ruta: '/dashboard/notificaciones')
            ],
            ),
            

        ]),
    );
  }
}