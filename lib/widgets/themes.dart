import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: GoogleFonts.lato().fontFamily,
      );
  static darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        fontFamily: GoogleFonts.lato().fontFamily,
      );
}
