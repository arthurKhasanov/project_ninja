import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    primaryColor: Colors.indigo,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: Colors.indigo,
    //   selectionColor: Colors.indigoAccent,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red[400]!, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red[400]!, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.indigo),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        alignment: Alignment.center,
        fixedSize: MaterialStateProperty.all(const Size(double.infinity, 48)),
      ),
    ),
  );
}
