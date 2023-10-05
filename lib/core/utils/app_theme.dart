import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.poppins.toString(),
    primaryColor: const Color(0xff007848),
    hoverColor: const Color(0xffB7083C),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 34,
      ),
      titleMedium: TextStyle(
        fontSize: 26,
      ),
      titleSmall: TextStyle(
        fontSize: 22,
      ),
      headlineLarge: TextStyle(
        fontSize: 20,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
      ),
    ),
  );
}
