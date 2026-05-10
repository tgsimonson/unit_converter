// main.dart
// Entry point for the Unit Converter app.
// Initializes the app and sets the converter screen as the home screen.

import 'package:flutter/material.dart';
import 'screens/converter_screen.dart';

void main() {
  runApp(const UnitConverterApp());
}

/// The root widget of the application.
/// Sets up the theme and points to the home screen.
class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ConverterScreen(),
    );
  }
}