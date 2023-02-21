import 'package:flutter/material.dart';
import 'dart:math';

class ColourProvider with ChangeNotifier {
  Random random = Random();
  Color backgroundColour = const Color.fromRGBO(255, 255, 255, 1);
  Color _decorationColour = Colors.black;
  Color _randomColour = const Color.fromRGBO(255, 255, 255, 1);

  Color get randomColour => _randomColour;
  Color get decorationColour => _decorationColour;

  void screenRandomColour() {
    _randomColour = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1
      //random.nextDouble(),
    );
    _decorationColour = getTextColorForBackground(randomColour);
    notifyListeners();
  }

  Color getTextColorForBackground(Color backgroundColour) {
    if (ThemeData.estimateBrightnessForColor(backgroundColour) ==
        Brightness.dark) {
      return Colors.white;
    }
    return Colors.black;
  }

  Color _userChosenColour = const Color.fromRGBO(255, 255, 255, 1);

  Color get userChosenColour => _userChosenColour;

  showChosenColour(String r, String g, String b) {
    _userChosenColour = Color.fromRGBO(
      int.parse(r),
      int.parse(g),
      int.parse(b),
      1,
    );
    _decorationColour = getTextColorForBackground(userChosenColour);
    notifyListeners();
  }

  void showComplementaryColour(String r, String g, String b) {
    _userChosenColour = Color.fromRGBO(
      255 - int.parse(r),
      255 - int.parse(g),
      255 - int.parse(b),
      1,
    );
    _decorationColour = getTextColorForBackground(userChosenColour);
    notifyListeners();
  }


}
