import 'package:feriaweb/datatables/payments_datasource.dart';
import 'package:feriaweb/ui/cards/white_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PagosPendientes extends StatelessWidget {
  const PagosPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            decoration: buildBoxDecoration(),
            child: PaginatedDataTable(
              columns: [
                DataColumn(
                    label: Text('Número Carga',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Tipo de Carga',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Destinatario',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Monto a Pagar',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Estado Pago',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Método de Pago',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Información',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              source: PaymentsDatasource(),
              header: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.attach_money_outlined,
                      size: 25, color: Colors.black),
                  SizedBox(width: 10),
                  Text('Pagos Pendientes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ],
              ),
              rowsPerPage: 5,
            ),
          ),
          Center(
            child: WhiteCard(
              width: 784,
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(onPressed: (){},
                            icon: Icon(Icons.arrow_back_outlined)),
                            SizedBox(width: 20),
                            Center(
                              child: Text('Seleccione Metodos de Pago',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500, fontSize: 24)),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Aquí encontrarás un listado de los pagos pendientes que tienes por realizar. Puedes realizar el pago de cada uno de ellos haciendo clic en el botón "Realizar pago".',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ))),
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
