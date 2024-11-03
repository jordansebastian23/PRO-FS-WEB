import 'package:feriaweb/ui/cards/white_card.dart';
import 'package:feriaweb/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class BlankView extends StatelessWidget {
  const BlankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Dashboard', style: CustomLabels.h1),

          SizedBox(height: 10),

          WhiteCard(
            title: 'White Card',
            child: Container(
              height: 200,
              width: 300,
              child: Placeholder(),
            ),
          ),
        ],
      )
    );
  }
}