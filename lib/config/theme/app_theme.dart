import 'package:flutter/material.dart';

const Color mainColor = Color.fromARGB(255, 26, 57, 91);
class AppTheme {
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: mainColor,
    );
  }
}