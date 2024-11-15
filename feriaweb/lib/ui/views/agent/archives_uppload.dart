import 'package:feriaweb/datatables/archive_uppload_datasource.dart';
import 'package:feriaweb/services/files_view.dart';
import 'package:flutter/material.dart';

class ArchivesUppload extends StatefulWidget {

  const ArchivesUppload({super.key});

  @override
  State<ArchivesUppload> createState() => _ArchivesUpploadState();

}

  class _ArchivesUpploadState extends State<ArchivesUppload> {
  List<dynamic> allArchives = [];
  List<dynamic> filteredArchives = [];
  late Future<List<dynamic>> _archivesFuture;

  void initState() {
    super.initState();
    _fetchFiles();
    _archivesFuture = FilesView.fetchFiles();
  }

  _fetchFiles() async {
    try {
    allArchives = await FilesView.fetchFiles();
    setState(() {
      filteredArchives = allArchives;
    });
    } catch (e) {
      print('Error loading archives: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: _archivesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final archives = snapshot.data ?? [];
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
                  columns: [
                    DataColumn(
                        label: Text('ID Archivo',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Usuario',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Nombre archivo',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Fecha subida',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Estado',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                    DataColumn(
                        label: Text('Detalles',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  source: ArchiveUpploadDatasource(context, archives),
                  header: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text('Archivos Subidos',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                      ),
                    ],
                  ),
                  rowsPerPage: 10,
                ),
              ),
            ),
          )
        ],
      );
      }
    },
    ),
    );
  }
}
  BoxDecoration buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(20),
      );