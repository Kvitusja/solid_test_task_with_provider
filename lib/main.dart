import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';
import 'screens/animated_colours_screen.dart';
import 'screens/choose_colour.dart';
import 'screens/colours_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ColourProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const ColoursScreen(),
            ChooseColour.routeName: (context) => const ChooseColour(),
            AnimatedColoursScreen.routeName: (context) =>
                const AnimatedColoursScreen(),
          },
        ));
  }
}
