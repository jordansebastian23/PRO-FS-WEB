import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollcontroler = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            controller: scrollcontroler,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.3,
                  width: constraints.maxWidth,
                  color: Colors.blue,
                  child: Center(
                    child: Text('Header'),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  width: constraints.maxWidth,
                  color: Colors.red,
                  child: Center(
                    child: Text('Body'),
                  ),
                ),
              ],
            ),
          ),
        )
      );
    });
  }
}