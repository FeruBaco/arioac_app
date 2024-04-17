import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Color(0xff424CB8);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);

class AppTheme {
  ThemeData getTheme() => ThemeData(
        ///* General
        useMaterial3: true,
        colorSchemeSeed: colorSeed,

        ///* Texts
        textTheme: TextTheme(
          titleLarge: GoogleFonts.arimo().copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
          titleMedium: GoogleFonts.arimo().copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: GoogleFonts.arimo().copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          labelLarge: GoogleFonts.arimo().copyWith(
            fontSize: 16,
          ),
          labelMedium: GoogleFonts.arimo().copyWith(
            fontSize: 15,
          ),
          labelSmall: GoogleFonts.arimo().copyWith(
            fontSize: 14,
          ),
        ),

        ///* Scaffold Background Color
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),

        ///* AppBar
        // appBarTheme: AppBarTheme(
        //   color: scaffoldBackgroundColor,
        //   titleTextStyle: GoogleFonts.openSans().copyWith(
        //       fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        // ),
      );
}
