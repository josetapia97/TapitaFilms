import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getLightTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xff2862f5),
    brightness: Brightness.light,
  );

  ThemeData getDarkTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.white,
    brightness: Brightness.dark,
  );
}





