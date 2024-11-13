import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/datatables/payments_datasource.dart';
import 'package:feriaweb/services/edit_account.dart';
import 'package:feriaweb/services/pagos_view.dart';
import 'package:feriaweb/ui/buttons/custom_icontext_button.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class User {
  final String nombre;
  final String correo;

  User({required this.nombre, required this.correo});
}

class PaymentsSuccess extends StatefulWidget {
  const PaymentsSuccess({super.key});

  @override
  State<PaymentsSuccess> createState() => _PaymentsSuccessState();
}

class _PaymentsSuccessState extends State<PaymentsSuccess> {
  User? selectedUser;
  String? amount;
  DateTime? _selectedDate;
  List<dynamic> allUsers = [];
  List<dynamic> filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  late Future<List<dynamic>> _pagosFuture;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _pagosFuture = PagosService.fetchPagos();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    try {
      allUsers = await EditAccountService.getUsers();
      setState(() {
        filteredUsers = allUsers;
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  void _onSearchChanged() {
    setState(() {
      filteredUsers = allUsers
          .where((user) =>
              user['display_name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
              user['email'].toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('es', 'ES'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: CustomColor.buttons, // Cambia el color primario
            colorScheme: ColorScheme.light(primary: CustomColor.buttons), // Cambia el esquema de color
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Cambia el tema del botón
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _createPago() async {
    if (selectedUser == null || amount == null || amount!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Debes seleccionar un usuario y un monto'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await PagosService.createPago(
        email: selectedUser!.correo,
        monto: int.parse(amount!),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
      setState(() {
        _pagosFuture = PagosService.fetchPagos();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create pago: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: _pagosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pagos = snapshot.data ?? [];
            return ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 900,
                    child: Container(
                      decoration: buildBoxDecoration(),
                      child: PaginatedDataTable(
                        actions: [
                          //filtrar por fecha field
                          Row(
                            children: [
                              CustomIcontextButton(
                                  title: 'Filtrar por fecha',
                                  color: Colors.blueAccent,
                                  icon: Icons.calendar_month_outlined,
                                  onPressed: () => _selectDate(context)),
                              //Reestablecer filtro
                              CustomIcontextButton(
                                  title: 'Reestablecer filtro',
                                  color: Colors.redAccent,
                                  icon: Icons.replay_outlined,
                                  onPressed: () {
                                    setState(() {
                                      _selectedDate = null;
                                    });
                                  }),
                              CustomIcontextButton(
                                  title: 'Crear Nuevo pago',
                                  color: CustomColor.buttons,
                                  icon: Icons.add,
                                  onPressed: () {
                                    _newPay(context);
                                  }),
                            ],
                          )
                        ],
                        columnSpacing: 1,
                        columns: [
                          DataColumn(
                              label: Text('ID Usuario',
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Usuario',
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Monto',
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Fecha de Creación',
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Estado',
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Detalles',
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        source: PaymentsDatasource(context, pagos),
                        header: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Historial de pagos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 24)),
                                  SizedBox(height: 10),
                                  //Fecha actual
                                  Text(
                                      'Fecha: ${_selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : 'Seleccione una fecha'}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 14)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        rowsPerPage: 5,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _newPay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Crear Nuevo Pago'),
              content: SingleChildScrollView(
                child: Container(
                  width: 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Seleccionar Usuario: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              enabled: false,
                              decoration: CustomInputs.createUser(
                                hint: 'Seleccione un usuario',
                                label: selectedUser != null
                                    ? selectedUser!.nombre
                                    : 'Selecciona un usuario',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () async {
                              _showUserSelectionDialog(context, setState);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Ingresa monto [\$CLP]',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400, fontSize: 13)),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 140,
                        height: 43,
                        child: TextFormField(
                          decoration: CustomInputs.createUser(
                            colorBorder: Colors.black,
                            hint: 'Ingresa el monto',
                            label: 'Monto',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            amount = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.buttons,
                  ),
                  child: Text('Cancelar',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.buttons,
                  ),
                  child: Text('Confirmar',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16)),
                  onPressed: () {
                    _createPago();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showUserSelectionDialog(BuildContext context, StateSetter setState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: Text(
                'Busqueda por Email',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 13),
              ),
              content: SingleChildScrollView(
                child: Container(
                  width: 400,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Buscar: ',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500, fontSize: 20)),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: CustomInputs.searchBar(
                                icon: Icons.search,
                                colorBorder: Colors.black,
                                hint: 'Ingresa el email o nombre del usuario',
                                label: 'Buscar usuario',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            final nombre = user['display_name'] ?? 'Usuario desconocido';
                            final correo = user['email'] ?? 'Sin correo';

                            return ListTile(
                              title: Row(
                                children: [
                                  Checkbox(
                                    value: selectedUser?.correo == correo,
                                    onChanged: (value) {
                                      setStateDialog(() {
                                        selectedUser = User(
                                          nombre: nombre,
                                          correo: correo,
                                        );
                                      });
                                      setState(() {
                                        selectedUser = User(
                                          nombre: nombre,
                                          correo: correo,
                                        );
                                      });
                                      Navigator.of(context).pop(); // Cerrar diálogo
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  CircleAvatar(),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(nombre,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14)),
                                      Text(correo,
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14)),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                setStateDialog(() {
                                  selectedUser = User(
                                    nombre: nombre,
                                    correo: correo,
                                  );
                                });
                                setState(() {
                                  selectedUser = User(
                                    nombre: nombre,
                                    correo: correo,
                                  );
                                });
                                Navigator.of(context).pop(); // Cerrar diálogo
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.buttons,
                  ),
                  child: Text('Cancelar',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColor.buttons,
                  ),
                  child: Text('Confirmar',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(20),
      );
}
