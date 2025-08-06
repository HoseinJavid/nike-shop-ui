import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LightTheme {
  static const Color primaryColor = Color(0xff217CF3);
  static const secondryColor = Color(0xff242936);
  static const Color tertiaryColor = Color(0xffF5F5F5);
  static const Color primaryButtonColor = Color(0xffFFFFFF);
  static const Color primaryTextColor = Color(0xff000000);
  static const Color secondaryTextColor = Color(0xff7A7A7A);
  static const Color tertiaryTextColor = Color(0xffF5F5F5);

  ThemeData getLightTheme(Locale locale) {
    return ThemeData(
      fontFamily: locale.languageCode == 'fa' ? 'IranYekan' : null,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: tertiaryColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: primaryTextColor),
        bodyMedium: TextStyle(color: secondaryTextColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          overlayColor: primaryColor.withOpacity(0.1),
          backgroundColor: secondryColor,
          foregroundColor: primaryButtonColor,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: secondaryTextColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryTextColor,
          // textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          overlayColor: primaryColor.withOpacity(0.1),
        ),
      ),
    );
  }
}

//ai generated
class DarkThemeColors {
  static const primaryColor = Color(0xff217CF3);
  static const secondryColor = Color(0xff1A1A1A);
  static const primaryTextColor = Color(0xffffffff);
  static const secondryTextColor = Color(0xffB3B3B3);
}
