import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(147, 210, 240, 255),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.balooBhai2().fontFamily,
      fontSize: 64,
      fontWeight: FontWeight.w900,
    ),
    labelLarge: TextStyle(
      fontFamily: GoogleFonts.balooBhai2().fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    )
  ),
  useMaterial3: true,
);
