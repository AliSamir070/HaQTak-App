import 'package:flutter/material.dart';

class AppStyle{
  static Color onBoardingColor = Color(0xffB9FFF8);
  static Color accentColor = Color(0xffFF9551);
  static Color primaryColor = Color(0xff6FEDD6);
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    canvasColor: accentColor,

    secondaryHeaderColor: onBoardingColor,
    scaffoldBackgroundColor: onBoardingColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: accentColor,
        fontSize: 22,
        fontWeight: FontWeight.bold
      )
    ),
    hintColor: Colors.grey,
    textTheme: TextTheme(
      headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
      ),
      bodySmall: TextStyle(
          color: Colors.grey[400],
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
      headlineSmall: TextStyle(
          color: accentColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),
      headlineLarge: TextStyle(
          color: accentColor,
          fontSize: 30,
          fontWeight: FontWeight.bold
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 22
      ),
      bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 18
      ),
      titleMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: accentColor
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        color: accentColor,
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        color: Colors.grey,
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.black
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),
      labelLarge: TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontWeight: FontWeight.w800
      )
    )
  );
}