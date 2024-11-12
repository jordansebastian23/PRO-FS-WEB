import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/datatables/carga_datasource.dart';
import 'package:feriaweb/ui/buttons/custom_icontext_button.dart';
import 'package:feriaweb/ui/cards/custom_card_notify.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class User {
  final String nombre;
  final String correo;

  User({required this.nombre, required this.correo});
}

class CargaView extends StatefulWidget {
  const CargaView({super.key});

  @override
  State<CargaView> createState() => _CargaViewState();
}

class _CargaViewState extends State<CargaView> {
  DateTime? _selectedDate;
  DateTime? _selectedDateRetiro;
  User? selectedUser;
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<User>> _filteredUsersNotifier =
      ValueNotifier<List<User>>([]);

  List<User> allUsers = [
    User(nombre: 'Usuario 1', correo: 'usuario1@example.com'),
    User(nombre: 'Usuario 2', correo: 'usuario2@example.com'),
    User(nombre: 'Usuario 3', correo: 'usuario3@example.com'),
    User(nombre: 'Usuario 4', correo: 'usuario4@example.com'),
  ];

  @override
  void initState() {
    super.initState();
    _filteredUsersNotifier.value = allUsers;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filteredUsersNotifier.value = allUsers
        .where((user) =>
            user.nombre
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            user.correo
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();
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
            colorScheme: ColorScheme.light(
                primary: CustomColor.buttons), // Cambia el esquema de color
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary), // Cambia el tema del botón
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedDateRetiro = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
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
                            title: 'Crear Nueva carga',
                            color: CustomColor.buttons,
                            icon: Icons.add,
                            onPressed: () {
                              _newCarga(context);
                            }),
                      ],
                    )
                  ],
                  columnSpacing: 1,
                  columns: [
                    DataColumn(
                        label: Text('ID Carga',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Fecha Creacion',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Fecha Retiro',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Monto Relacionado',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Estado',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Detalles',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  source: CargaDatasource(context),
                  header: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gestionar cargas',
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
      ),
    );
  }

  void _newCarga(BuildContext context) {
    String? amount;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Crear Nueva Carga'),
              content: SingleChildScrollView(
                child: Container(
                  width: 800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Seleccionar Usuario: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                                Spacer(),
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
                            Row(
                              children: [
                                Text('Fecha de creacion: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                                Spacer(),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    enabled: false,
                                    decoration: CustomInputs.createUser(
                                      hint: 'Seleccione una fecha',
                                      label: _selectedDateRetiro != null
                                          ? DateFormat('yyyy-MM-dd')
                                              .format(_selectedDateRetiro!)
                                          : 'Selecciona una fecha',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    await _selectDate(context);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Fecha de retiro:   ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                                Spacer(),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    enabled: false,
                                    decoration: CustomInputs.createUser(
                                      hint: 'Seleccione una fecha',
                                      label: _selectedDateRetiro != null
                                          ? DateFormat('yyyy-MM-dd')
                                              .format(_selectedDateRetiro!)
                                          : 'Selecciona una fecha',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    await _selectDate(context);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 40),
                      Container(
                        width: 10,
                        height: 100,
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Ingresa monto [\$CLP]',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 13),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: 200,
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
                            SizedBox(height: 8),
                            Text(
                              'Ingrese descripción',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 13),
                            ),
                            SizedBox(
                              width: 200,
                              height: 100,
                              child: TextFormField(
                                decoration: CustomInputs.createUser(
                                  colorBorder: Colors.black,
                                  hint: 'Ingresa la descripción',
                                  label: 'Descripción',
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                              ),
                            )
                          ],
                        ),
                      )
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
                  child: Text('Crear Carga',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16)),
                  onPressed: () {
                    _showConfirmCreationCarga(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showConfirmCreationCarga(BuildContext contex) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Confirmar creación de carga'),
        content: Text('¿Estás seguro de que deseas crear esta carga?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    SizedBox(width: 10),
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
          ),
        ],
      );
    });
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
                        child: ValueListenableBuilder<List<User>>(
                          valueListenable: _filteredUsersNotifier,
                          builder: (context, filteredUsers, _) {
                            return ListView(
                              children: filteredUsers
                                  .map((user) => ListTile(
                                        title: Row(
                                          children: [
                                            Checkbox(
                                              value: selectedUser == user,
                                              onChanged: (value) {
                                                setStateDialog(() {
                                                  selectedUser = user;
                                                });
                                                setState(() {
                                                  selectedUser = user;
                                                });
                                                Navigator.of(context)
                                                    .pop(); // Cerrar diálogo
                                              },
                                            ),
                                            SizedBox(width: 10),
                                            CircleAvatar(),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(user.nombre,
                                                    style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                                Text(user.correo,
                                                    style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setStateDialog(() {
                                            selectedUser = user;
                                          });
                                          setState(() {
                                            selectedUser = user;
                                          });
                                          Navigator.of(context)
                                              .pop(); // Cerrar diálogo
                                        },
                                      ))
                                  .toList(),
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
