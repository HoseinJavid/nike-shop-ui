import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData getTheme({required Locale locale}) {
    String fontFamily = 'iranYekan';
    return ThemeData(
        textTheme: locale == const Locale('fa', 'IR')
            ? TextTheme(
                titleSmall: TextStyle(fontFamily: fontFamily),
                headlineMedium: TextStyle(fontFamily: fontFamily),
                bodyLarge: TextStyle(fontFamily: fontFamily),
                bodyMedium: TextStyle(fontFamily: fontFamily),
                titleLarge: TextStyle(
                    fontFamily: fontFamily, fontWeight: FontWeight.bold))
            : null,
        colorScheme: const ColorScheme.light(
            primary: Color(0xff217CF3),
            secondary: Color(0xff262A35),
            onPrimary: Color(0xff262A35),
            onSecondary: Color(0xffB3B6BE)),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6), fontFamily: fontFamily),
          labelStyle: TextStyle(
              color: Colors.white.withOpacity(0.6), fontFamily: fontFamily),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.35)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamily),
          ),
          foregroundColor: const WidgetStatePropertyAll(Colors.black),
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        )),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
                color: Colors.white),
          ),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
        )));
  }
}
