import 'package:feriaweb/datatables/archive_uppload_datasource.dart';
import 'package:flutter/material.dart';


class ArchivesUppload extends StatelessWidget {
  const ArchivesUppload({super.key});

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
                  columnSpacing: 1,
                  columns: [
                    DataColumn(
                        label: Text('ID Usuario',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('N° tramite',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('N° Carga',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('tipo de carga',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Archivos faltantes',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tipo de archivos',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Estado',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    
                    DataColumn(
                        label: Text('Detalles',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  source: ArchiveUpploadDatasource(),
                  header: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text('Archivos Subidos',
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                      ),
                    ],
                  ),
                  rowsPerPage: 5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  BoxDecoration buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.black,
        width: 1),
    borderRadius: BorderRadius.circular(20),
          
          );

}