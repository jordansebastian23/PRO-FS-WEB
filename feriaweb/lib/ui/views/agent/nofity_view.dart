import 'package:feriaweb/services/edit_account.dart';
import 'package:feriaweb/services/get_roles.dart';
import 'package:feriaweb/services/notification_view.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/cards/custom_card_notify.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NofityView extends StatefulWidget {
  const NofityView({super.key});

  @override
  State<NofityView> createState() => _NofityViewState();
}

class _NofityViewState extends State<NofityView> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  List<dynamic> _users = [];
  List<String> _roles = [];
  List<dynamic> _filteredUsers = [];
  List<String> _selectedUserEmails = [];
  String? _selectedRole; // Set this to nullable to avoid dropdown error
  int _selectedRadio = 1;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
    _loadRoles();
  }

  Future<void> _fetchUsers() async {
    _users = await EditAccountService.getUsers();
    setState(() {
      _filteredUsers = _users;
    });
  }

  Future<void> _loadRoles() async {
    try {
      final roles = await RoleService.fetchRoles();
      setState(() {
        _roles = roles;
      });
    } catch (e) {
      print('Error loading roles: $e');
    }
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        final email = user['email'].toLowerCase();
        return email.contains(query);
      }).toList();
    });
  }

  String _getTitleBasedOnSelection() {
    switch (_selectedRadio) {
      case 1:
        return 'Urgent Notification';
      case 2:
        return 'Needs Attention';
      case 3:
        return 'New Update';
      default:
        return 'Notification';
    }
  }

  void _sendNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Authorization token missing")),
      );
      return;
    }

    final selectedTitle = _getTitleBasedOnSelection();
    final message = _messageController.text.trim();

    try {
      final response = await NotificationService.createNotification(
        titulo: selectedTitle,
        mensaje: message,
        destinos: _selectedUserEmails,
        token: token,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send notification: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 1000,
        height: 700,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        hintText: 'Search Users',
                        labelText: 'Search Users',
                        labelStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: () {
                      // Add your search logic here
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
// Users List to Select Multiple Users
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: _filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = _filteredUsers[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedUserEmails.contains(user['email'])
                                ? Colors.blue[50]
                                : Colors.white,
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value:
                                  _selectedUserEmails.contains(user['email']),
                              onChanged: (bool? selected) {
                                setState(() {
                                  if (selected == true) {
                                    _selectedUserEmails.add(user['email']);
                                  } else {
                                    _selectedUserEmails.remove(user['email']);
                                  }
                                });
                              },
                            ),
                            title: Text(
                              user['email'],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color:
                                    _selectedUserEmails.contains(user['email'])
                                        ? Colors.blue
                                        : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Notification Type Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCardNotify(
                    icon: Icons.error_outline_outlined,
                    title: 'Urgent Notification',
                    textRadio: 'Error / Warning',
                    colorBorder: Colors.red,
                    colorIcon: Colors.red,
                    value: 1,
                    groupValue: _selectedRadio,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRadio = value!;
                      });
                    },
                    state: 'Notificacion Urgente',
                    notificationController: _messageController,
                  ),
                  CustomCardNotify(
                    icon: Icons.error_outline_outlined,
                    title: 'Needs Attention',
                    textRadio: 'Pending',
                    colorBorder: Colors.amber,
                    colorIcon: Colors.amber,
                    value: 2,
                    groupValue: _selectedRadio,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRadio = value!;
                      });
                    },
                    state: 'Requiere Atencion',
                    notificationController: _messageController,
                  ),
                  CustomCardNotify(
                    icon: Icons.info_outline,
                    title: 'New Update',
                    textRadio: 'Notice',
                    colorBorder: Colors.blue,
                    colorIcon: Colors.blue,
                    value: 3,
                    groupValue: _selectedRadio,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedRadio = value!;
                      });
                    },
                    state: 'Nueva Actualizacion',
                    notificationController: _messageController,
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomOutlinedButton(
                isFilled: true,
                color: Colors.blue,
                onPressed: _sendNotification,
                text: 'Send Notification',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
