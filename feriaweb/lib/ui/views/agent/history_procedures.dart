import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/datatables/history_datasource.dart';
import 'package:feriaweb/services/cargas_view.dart';
import 'package:feriaweb/services/edit_account.dart';
import 'package:feriaweb/services/tramite_view.dart';
import 'package:feriaweb/ui/buttons/custom_icontext_button.dart';
import 'package:feriaweb/ui/buttons/custom_multiselector_archives.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
import 'package:feriaweb/ui/buttons/custom_radio_archives.dart';
import 'package:feriaweb/ui/buttons/custom_radio_selectprocedure.dart';
import 'package:feriaweb/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class User {
  final String nombre;
  final String correo;

  User({required this.nombre, required this.correo});
}

class HistoryTramites extends StatefulWidget {
  const HistoryTramites({super.key});

  @override
  State<HistoryTramites> createState() => _HistoryTramitesState();
}

class _HistoryTramitesState extends State<HistoryTramites> {
  int _selectedRadio = 1;
  List<int> _selectedFileValues = [];
  int? selectedCargaId;
  DateTime? _selectedDate;
  DateTime? _selectedDateRetiro;
  User? selectedUser;
  List<dynamic> allUsers = [];
  List<dynamic> filteredUsers = [];
  List<dynamic> allCargas = [];
  List<dynamic> filteredCargas = [];
  final TextEditingController _searchController = TextEditingController();
  late Future<List<dynamic>> _tramitesFuture;

  String _getTipoTramiteBasedOnValue() {
    switch (_selectedRadio) {
      case 1:
        return "FCL DIRECTO";
      case 2:
        return "FCL INDIRECTO";
      case 3:
        return "LCL DIRECTO";
      case 4:
        return "LCL INDIRECTO";
      default:
        return "FCL DIRECTO";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCargas();
    _fetchUsers();
    _tramitesFuture = TramiteService.fetchTramites();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _fetchCargas() async {
    try {
      allCargas = await CargasService.fetchCargas();
      setState(() {
        filteredCargas = allCargas;
      });
    } catch (e) {
      print('Error fetching cargas: $e');
    }
  }

  _fetchUsers() async {
    try {
      allUsers = await EditAccountService.getUsers();
      setState(() {
        filteredUsers = allUsers;
      });
    } catch (e) {
      print('Error fetching users: $e');
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

  Future <void> _createTramite() async {
    final selectedTipoTramite = _getTipoTramiteBasedOnValue();
    try {
      await TramiteService.createTramite(
        tipo_tramite: selectedTipoTramite,
        usuarioDestino: selectedUser!.correo,
        cargaId: selectedCargaId!,
        fileTypeIds: _selectedFileValues,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tramite creado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        _selectedRadio = 1;
        _selectedDate = null;
        _selectedDateRetiro = null;
        selectedUser = null;
        _selectedFileValues = [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear el tramite: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60),
      child: FutureBuilder<List<dynamic>>(
        future: _tramitesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final tramites = snapshot.data ?? [];
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
                  columnSpacing: 1,
                  actions: [
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
                            title: 'Crear Nuevo Tramite',
                            color: CustomColor.buttons,
                            icon: Icons.add,
                            onPressed: () {
                              _newTramite(context);
                            }),
                      ],
                    )
                  ],
                  columns: [
                    DataColumn(
                        label: Text('Fecha de tramite',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('N° Tramite',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('N° Carga',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tipo de carga',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Destinatario',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Fecha Termino',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Estado de tramite',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Detalles',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  source: HistoryDatasource(context, tramites),
                  header: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Historial de tramites',
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

    

  void _newTramite(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Crear Nuevo Tramite'),
              content: SingleChildScrollView(
                child: Container(
                  width: 800,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5),
                          SizedBox(
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Seleccione el tipo de carga',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                SizedBox(height: 5),
                                CustomRadioSelectprocedure(
                                  title: 'Contenedor de Carga Completa',
                                  subTitle: '[FCL] Directo',
                                  value: 1,
                                  groupValue: _selectedRadio,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedRadio = value!;
                                    });
                                  },
                                ),
                                SizedBox(height: 5),
                                CustomRadioSelectprocedure(
                                  title: 'Contenedor de Carga Completa',
                                  subTitle: '[FCL] Indirecto',
                                  value: 2,
                                  groupValue: _selectedRadio,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedRadio = value!;
                                    });
                                  },
                                ),
                                SizedBox(height: 5),
                                CustomRadioSelectprocedure(
                                  title: 'Carga Inferior a un Contenedor',
                                  subTitle: '[LCL] Directo',
                                  value: 3,
                                  groupValue: _selectedRadio,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedRadio = value!;
                                    });
                                  },
                                ),
                                SizedBox(height: 5),
                                CustomRadioSelectprocedure(
                                  title: 'Carga Inferior a un Contenedor',
                                  subTitle: '[LCL] Indirecto',
                                  value: 4,
                                  groupValue: _selectedRadio,
                                  onChanged: (int? value) {
                                    
                                    setState(() {
                                      _selectedRadio = value!;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 40),
                          Container(
                            width: 10,
                            height: 150,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                          ),
                          SizedBox(width: 40),
                          Container(
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Datos de la carga',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.search),
                                      onPressed: () async {
                                        _showUserSelectionDialog(
                                            context, setState);
                                      },
                                    ),
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
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.local_shipping),
                                      onPressed: () async {
                                        _showCargasSelectionDialog(
                                            context, setState);
                                      },
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: TextField(
                                        enabled: false,
                                        decoration: CustomInputs.createUser(
                                          hint: 'Seleccione una fecha',
                                          label: selectedCargaId != null
                                              ? selectedCargaId.toString()
                                              : 'Selecciona una carga',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      //Archivos
                      Divider(
                        color: Colors.black,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(height: 10),
                      Text('Archivos Requeridos',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 16)),
                      SizedBox(height: 10),
                        Row(
                        children: [
                          SizedBox(width: 20),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomMultiSelectorArchives(
                            title: 'Boleta de pago.pdf',
                            subTitle: 'Boleta de pago de la carga',
                            value: 1,
                            selectedValues: _selectedFileValues,
                            onChanged: (List<int> values) {
                              setState(() {
                              _selectedFileValues = values;
                              });
                            },
                            ),
                            SizedBox(height: 10),
                            CustomMultiSelectorArchives(
                            title: 'Archivo de retiro.pdf',
                            subTitle: 'Archivo que acredite el retiro de la carga',
                            value: 2,
                            selectedValues: _selectedFileValues,
                            onChanged: (List<int> values) {
                              setState(() {
                              _selectedFileValues = values;
                              });
                            },
                            ),
                            SizedBox(height: 10),
                            CustomMultiSelectorArchives(
                            title: 'Carnet.pdf',
                            subTitle: 'Cédula de identidad',
                            value: 3,
                            selectedValues: _selectedFileValues,
                            onChanged: (List<int> values) {
                              setState(() {
                              _selectedFileValues = values;
                              });
                            },
                            ),
                          ],
                          ),
                          SizedBox(width: 20),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomMultiSelectorArchives(
                            title: 'Carnet de Conductor.pdf',
                            subTitle: 'Cédula de identidad',
                            value: 4,
                            selectedValues: _selectedFileValues,
                            onChanged: (List<int> values) {
                              setState(() {
                              _selectedFileValues = values;
                              });
                            },
                            ),
                            SizedBox(height: 10),
                            CustomMultiSelectorArchives(
                            title: 'Archivo de Información de Aduanas.pdf',
                            subTitle: 'Archivo con Información de Aduanas',
                            value: 5,
                            selectedValues: _selectedFileValues,
                            onChanged: (List<int> values) {
                              setState(() {
                              _selectedFileValues = values;
                              });
                            },
                            ),
                            SizedBox(height: 10),
                            CustomMultiSelectorArchives(
                            title: 'Archivo de Visado.pdf',
                            subTitle: 'Archivo con visado de la carga',
                            value: 6,
                            selectedValues: _selectedFileValues,
                            onChanged: (List<int> values) {
                              setState(() {
                              _selectedFileValues = values;
                              });
                            },
                            ),
                          ],
                          ),
                        ],
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
                  child: Text('Crear Tramite',
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
    showDialog(
        context: context,
        builder: (context) {
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
                      _createTramite();
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
    void _showCargasSelectionDialog(BuildContext context, StateSetter setState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return AlertDialog(
                title: Text(
                  'Busqueda por ID de Carga',
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
                                  hint: 'Ingresa el ID de la carga',
                                  label: 'Buscar carga',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: filteredCargas.length,
                            itemBuilder: (context, index) {
                              final carga = filteredCargas[index];
                              final id = carga['id'] ?? 'ID desconocido';
                              final descripcion = carga['descripcion'] ?? 'Sin descripción';
                              final fechaCreacion = carga['fecha_creacion'] ?? 'Sin fecha de creación';

                              return ListTile(
                                title: Row(
                                  children: [
                                    Checkbox(
                                      value: selectedCargaId == id,
                                      onChanged: (value) {
                                        setStateDialog(() {
                                          selectedCargaId = id;
                                        });
                                        setState(() {
                                          selectedCargaId = id;
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
                                        Text('ID: $id',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                        Text('Descripción: $descripcion',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14)),
                                        Text('Fecha de Creación: ${DateFormat('dd/MM/yy').format(DateTime.parse(fechaCreacion))}',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                      ],
                                    ),
                                  ],
                                ),
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
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(20),
      );
