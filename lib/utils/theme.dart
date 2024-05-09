import 'package:flutter/material.dart';

class CommonMethod {
  ThemeData themeData = ThemeData(
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF006699),
        primaryContainer: Color.fromARGB(255, 202, 230, 245),
        onPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFFFF5D1),
        onSecondary: Color(0xFFFFC909),
        error: Color(0xFFA31920),
        onError: Color(0xFFA31920),
        background: Colors.white,
        onBackground: Colors.grey.shade700,
        surface: Colors.white,
        onSurface: Colors.grey.shade800),
    fontFamily: 'Open Sans',
    useMaterial3: true,

    /// Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium:
          TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, height: 2),
      headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF006699)),
      titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400),
      labelMedium: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontSize: 16.0, fontFamily: 'Open Sans'),
      bodyMedium:
          TextStyle(fontSize: 14.0, fontFamily: 'Open Sans', height: 1.2),
      bodySmall: TextStyle(
          fontSize: 12.0, fontFamily: 'Open Sans', color: Colors.white),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF006699),
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
    ),
  );
}
