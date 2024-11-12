import 'dart:convert';
import 'package:feriaweb/services/local_login.dart';
import 'package:feriaweb/services/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacionGoogle{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '642056532071-67cmvge6sle5tol7lhe2vfdgotlbmgdl.apps.googleusercontent.com');

  Future<String?> autentificaciongoogle({
    required Function onSuccess,
    required Function(String) onError,
  }) async{
    try {
      User? user;
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential userCredential = await _auth.signInWithPopup(googleProvider);
      user = userCredential.user;
    
    if (user != null) {
        // Temporarily hold the token until we verify the role
        final tempToken = await _checkOrCreateUserInDjango(user);

        // Check user role in Django
        final userData = await LoginService.getUserData(tempToken);
        if (userData['roles'] != null && userData['roles'].contains('Visado')) {
          // Save the token only if the user has the required role
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', tempToken);
          prefs.setString('loginType', 'google');
          await SessionManager.login(tempToken);
          
          onSuccess();
        } else {
          onError('User does not have the required "Visado" role.');
        }
      }
    } catch (e) {
      onError("Error in Google Authentication: $e");
    }
    return null;	
  }

  Future<void> logoutGoogleUser() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('loginType');
  }

  // Método para obtener el usuario actual
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<String> _checkOrCreateUserInDjango(User user) async {
    // Asignar ip del servidor
    final url = Uri.parse('http://192.168.1.90:8000/check_or_create_user/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'uid': user.uid,
        'email': user.email,
        'display_name': user.displayName,
        'photo_url': user.photoURL,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    } else {
      throw Exception('Failed to check or create user in Django');
    }
  }
}