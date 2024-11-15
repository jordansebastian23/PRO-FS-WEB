import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AboutGroup extends StatelessWidget {
  const AboutGroup({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text('Sobre el grupo', style: GoogleFonts.montserratAlternates(fontSize: 24, color: Colors.white)),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text('En LogiQuick, queremos hacer la logística más rápida,\n'
                    'eficiente y sostenible mediante soluciones digitales.\n'
                    'Nos enfocamos en facilitar los procesos logísticos para \nque sean más ágiles y seguros.',textAlign: TextAlign.justify, maxLines: 4,style: GoogleFonts.montserratAlternates(fontSize: 18, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 15),
                Text('Misión', style: GoogleFonts.montserratAlternates(fontSize: 24, color: Colors.white)),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text('Ofrecer soluciones digitales para la logística extraportuaria\nque minimicen el uso de papel, optimicen recursos, y \nreduzcan la huella de carbono en cada proceso.',textAlign: TextAlign.justify, maxLines: 4,style: GoogleFonts.montserratAlternates(fontSize: 18, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 15),
                Text('Integrantes', style: GoogleFonts.montserratAlternates(fontSize: 24, color: Colors.white)),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Francisca Prado',textAlign: TextAlign.justify, maxLines: 4,style: GoogleFonts.montserratAlternates(fontSize: 18, color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Nicolas Ramírez',textAlign: TextAlign.justify, maxLines: 4,style: GoogleFonts.montserratAlternates(fontSize: 18, color: Colors.white)),
                          ],
                        ),
                                                SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Vicente Ramírez',textAlign: TextAlign.justify, maxLines: 4,style: GoogleFonts.montserratAlternates(fontSize: 18, color: Colors.white)),
                          ],
                        ),
                                                SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Jordan Navarrete',textAlign: TextAlign.justify, maxLines: 4,style: GoogleFonts.montserratAlternates(fontSize: 18, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
