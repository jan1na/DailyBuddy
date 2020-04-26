import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData defaultTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    primaryColorDark: Colors.teal[700],
    accentColor: Colors.amber[500],
    errorColor: Colors.deepOrange[500],
    cardColor: Colors.blueGrey[100],
    backgroundColor: Colors.blueGrey[200],
  ),
  textTheme: GoogleFonts.ubuntuTextTheme(
    ThemeData.light().textTheme
  ).apply(
    displayColor: Colors.blueGrey[800],
    bodyColor: Colors.blueGrey[900],
    decorationColor: Colors.teal[700],
  ),
);

final ThemeData darkTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    primaryColorDark: Colors.teal[900],
    accentColor: Colors.amber[700],
    errorColor: Colors.deepOrange[300],
    cardColor: Colors.blueGrey[800],
    backgroundColor: Colors.blueGrey[900],
  ),
  textTheme: GoogleFonts.ubuntuTextTheme(
    ThemeData.dark().textTheme
  ).apply(
    displayColor: Colors.blueGrey[200],
    bodyColor: Colors.blueGrey[100],
    decorationColor: Colors.teal[300],
  ),
).copyWith(
  primaryColor: Colors.teal,
);
