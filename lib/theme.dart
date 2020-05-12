import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData setTheme(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: VIC.navy,
      backgroundColor: Colors.white,
      textTheme: GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
            title: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black)),
      ),
//      dividerColor: Colors.black26,
      dividerTheme:
          DividerThemeData(color: Colors.black26, thickness: 0, space: 2));
}

// Visual Identity Color.
class VIC {
  static const navy = Color(0xFF2D3047);
  static const red = Color(0xFFE84855);
  static const yellow = Color(0xFFF7B52C);
  static const green = Color(0xFF1B998B);
  static const border = Color(0xDDDDDD);
}
