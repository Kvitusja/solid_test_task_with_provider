import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider.dart';
import '../widgets/popup_menu_widget.dart';

class ColoursScreen extends StatefulWidget {
  const ColoursScreen({Key? key}) : super(key: key);

  @override
  State<ColoursScreen> createState() => _ColoursScreenState();
}

class _ColoursScreenState extends State<ColoursScreen> {
  Random random = Random();

  // Color getTextColorForBackground(Color backgroundColour) {
  //   if (ThemeData.estimateBrightnessForColor(backgroundColour) ==
  //       Brightness.dark) {
  //     return Colors.white;
  //   }
  //   return Colors.black;
  // }

  @override
  Widget build(BuildContext context) {
    final backgroundColour = Provider.of<ColourProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuWidget(
            color: backgroundColour.decorationColour,
          ),
        ],
      ),
      body: InkWell(
        onTap: () {
          backgroundColour.screenRandomColour();
        },
        child: Container(
          color: backgroundColour.randomColour,
          child: Center(
            child: Text(
              style: TextStyle(fontSize: 16, color: backgroundColour.decorationColour),
              'Hey there',
            ),
          ),
        ),
      ),
    );
  }
}
