import 'package:feriaweb/services/local_login.dart';
import 'package:feriaweb/services/session_manager.dart';
import 'package:feriaweb/ui/cards/custom_accessdirect_.dart';
import 'package:feriaweb/ui/cards/custom_card_dashboard_user.dart';
import 'package:flutter/material.dart';
import 'package:feriaweb/services/edit_account.dart';
import 'package:feriaweb/services/tramite_view.dart';
import 'package:feriaweb/services/files_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int totalUsers = 0;
  int enabledUsers = 0;
  int disabledUsers = 0;
  int pendingTramites = 0;
  int approvedTramites = 0;
  int uploadedFiles = 0;
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userData = await EditAccountService.getUsersDashboard();
      final tramiteData = await TramiteService.fetchTramitesDashboard();
      final filesCount = await FilesView.fetchFilesCount();

      final prefs = await SharedPreferences.getInstance();
      final user = await LoginService.getUserData(prefs.getString('token')!);

      setState(() {
        totalUsers = userData['totalUsers'];
        enabledUsers = userData['enabledUsers'];
        disabledUsers = userData['disabledUsers'];
        pendingTramites = tramiteData['pendingTramites'];
        approvedTramites = tramiteData['approvedTramites'];
        uploadedFiles = filesCount;
        userName = user['display_name'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 24, left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Dashboard', style: GoogleFonts.barlow(fontSize: 32, fontWeight: FontWeight.w600)),
          SizedBox(height: 5,),
          Text('Hola, ${userName}. ¡Bienvenidos de nuevo al panel de LogiQuick!', style: GoogleFonts.barlow(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 15,),
          SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCardUser(
                  title: 'Total Usuarios',
                  value: totalUsers.toString(),
                  icon: Icons.person_outline,
                  colorCircle: Color(0xff004080),
                ),
                CustomCardUser(
                  title: 'Usuarios Deshabilitados',
                  value: disabledUsers.toString(),
                  icon: Icons.person_off_outlined,
                  colorCircle: Color(0xFFE74C3C),
                ),
                CustomCardUser(
                  title: 'Usuarios Activos',
                  value: enabledUsers.toString(),
                  icon: Icons.person_outline,
                  colorCircle: Color(0xff004080),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCardUser(
                  title: 'Trámites Pendientes',
                  value: pendingTramites.toString(),
                  icon: Icons.content_paste,
                  colorCircle: Color(0xffBDC3C7),
                ),
                CustomCardUser(
                  title: 'Documentos Subidos',
                  value: uploadedFiles.toString(),
                  icon: Icons.upload_file,
                  colorCircle: Color(0xffF39C12),
                ),
                CustomCardUser(
                  title: 'Trámites Completados',
                  value: approvedTramites.toString(),
                  icon: Icons.check_box_outlined,
                  colorCircle: Color(0xff27AE60),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Accesos rápidos', style: GoogleFonts.barlow(fontSize: 24, fontWeight: FontWeight.w600)),
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
          ],
        ),
      );
  }
}