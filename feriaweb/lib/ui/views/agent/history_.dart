import 'package:feriaweb/constants/colors.dart';
import 'package:feriaweb/datatables/history_datasource.dart';
import 'package:feriaweb/ui/buttons/custom_outlined_button.dart';
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
                  source: HistoryDatasource(context),
                  header: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text('Historial de Tramites',
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                      ),
                      Spacer(),
                      CustomOutlinedButton(
                        onPressed: (){},
                        text: 'Nuevo Tramite',
                        isFilled: true,
                        color: CustomColor.buttons,)
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
