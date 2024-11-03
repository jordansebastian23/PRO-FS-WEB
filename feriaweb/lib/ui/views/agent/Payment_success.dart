import 'package:feriaweb/datatables/payments_datasource.dart';
import 'package:flutter/material.dart';

class PaymentsSuccess extends StatelessWidget {
  const PaymentsSuccess({super.key});

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
                        label: Text('N° Carga',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Tipo de Carga',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Nombre Destinatario',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Monto a Pagar',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Estado',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Metodo de pago',
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
                        child: Text('Pagos Realizados',
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
