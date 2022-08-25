import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

customTextStyle({
  double fontSize = 21,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return GoogleFonts.mulish(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
