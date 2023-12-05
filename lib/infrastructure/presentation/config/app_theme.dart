import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium:
              GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 15),
          bodyLarge: 
              GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 20),
          bodySmall: GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 10),
        ),
      );
}
