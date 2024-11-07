import 'package:feriaweb/datatables/payments_datasource.dart';
import 'package:flutter/material.dart';


class HistoryTramites extends StatelessWidget {
  const HistoryTramites({super.key});

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
                        label: Text('Archivos subidos',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Estado de tramite',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    
                    DataColumn(
                        label: Text('Detalles',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  source: PaymentsDatasource(context),
                  header: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text('Historial de Tramites',
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
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

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.black,
        width: 1),
    borderRadius: BorderRadius.circular(20),
          
          );
}
