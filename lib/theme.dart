import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData setTheme(context) {
  return ThemeData.light().copyWith(
      primaryColor: _MyColors.theme[500],
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
                fontSize: 16.0,
                color: Colors.black)),
      ),
//      dividerColor: Colors.black26,
      dividerTheme:
          DividerThemeData(color: Colors.black26, thickness: 0.0, space: 2.0));
}

class _MyColors {
  _MyColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> theme = const <int, Color>{
    500: const Color(0xFF2D3047),
    600: const Color(0xFFF7B52C),
  };
}
