import 'package:flutter/material.dart';

ThemeData getDarkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.black,
    ),
  );
}