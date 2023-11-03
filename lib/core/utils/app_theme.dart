import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
        onSecondary: Colors.white,
        onPrimary: Color(0xff007848),
        primary: Color(0xff007848)),
    fontFamily: GoogleFonts.poppins.toString(),
    primaryColor: const Color(0xff007848),
    hoverColor: const Color(0xffB7083C),
    secondaryHeaderColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 34, color: Colors.black),
      titleMedium: TextStyle(fontSize: 26, color: Colors.black),
      titleSmall: TextStyle(fontSize: 22, color: Colors.black),
      headlineLarge: TextStyle(fontSize: 20, color: Colors.black),
      headlineSmall: TextStyle(fontSize: 18, color: Colors.black),
      labelLarge: TextStyle(fontSize: 16, color: Colors.black),
      labelMedium: TextStyle(fontSize: 14, color: Colors.black),
      labelSmall: TextStyle(fontSize: 12, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
      bodySmall: TextStyle(fontSize: 12, color: Colors.black),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    secondaryHeaderColor: const Color.fromARGB(251, 26, 13, 29),
    colorScheme:
        const ColorScheme.dark(onSecondary: Color.fromARGB(209, 44, 2, 58)),
    fontFamily: GoogleFonts.poppins.toString(),
    primaryColor: const Color.fromARGB(255, 5, 101, 5),
    hoverColor: const Color(0xffFF5733),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 34, color: Colors.white),
      titleMedium: TextStyle(fontSize: 26, color: Colors.white),
      titleSmall: TextStyle(fontSize: 22, color: Colors.white),
      headlineLarge: TextStyle(fontSize: 20, color: Colors.white),
      headlineSmall: TextStyle(fontSize: 18, color: Colors.white),
      labelLarge: TextStyle(fontSize: 16, color: Colors.white),
      labelMedium: TextStyle(fontSize: 14, color: Colors.white),
      labelSmall: TextStyle(fontSize: 12, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
      bodySmall: TextStyle(fontSize: 12, color: Colors.white),
    ),
  );
}
