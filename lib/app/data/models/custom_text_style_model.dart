import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constants.dart';

class CustomTextStyles {
  static TextStyle normal(
      {double fontSizeDelta = 0,
      bool isBold = false,
      Color? color,
      double letterSpacing = 0.0}) {
    return GoogleFonts.sarabun(
      textStyle: TextStyle(
        fontSize: NORMAL_FONT_SIZE + fontSizeDelta,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing,
      ),
    );
  }

  static TextStyle small(
      {double fontSizeDelta = 0,
      bool isBold = false,
      Color? color,
      double letterSpacing = 0.0}) {
    return GoogleFonts.sarabun(
      textStyle: TextStyle(
        fontSize: SMALL_FONT_SIZE + fontSizeDelta,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing,
      ),
    );
  }

  static TextStyle appBar(
      {Color? color, bool isBold = false, double letterSpacing = 1.0}) {
    return GoogleFonts.sarabun(
      textStyle: TextStyle(
        fontSize: APP_BAR_FONT_SIZE,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing,
      ),
    );
  }

  static TextStyle drawer(
      {Color? color, bool isBold = false, double letterSpacing = 0.5}) {
    return GoogleFonts.sarabun(
      textStyle: TextStyle(
        fontSize: DRAWER_FONT_SIZE,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black,
        letterSpacing: letterSpacing,
      ),
    );
  }

  static TextStyle custom({
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    double letterSpacing = 0.0,
  }) {
    return GoogleFonts.sarabun(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
