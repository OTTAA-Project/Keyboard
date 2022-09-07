import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

MaterialColor kPrimaryMaterialColor = const MaterialColor(
  4278454289,
  <int, Color>{
    50: Color.fromRGBO(
      4,
      8,
      17,
      .1,
    ),
    100: Color.fromRGBO(
      4,
      8,
      17,
      .2,
    ),
    200: Color.fromRGBO(
      4,
      8,
      17,
      .3,
    ),
    300: Color.fromRGBO(
      4,
      8,
      17,
      .4,
    ),
    400: Color.fromRGBO(
      4,
      8,
      17,
      .5,
    ),
    500: Color.fromRGBO(
      4,
      8,
      17,
      .6,
    ),
    600: Color.fromRGBO(
      4,
      8,
      17,
      .7,
    ),
    700: Color.fromRGBO(
      4,
      8,
      17,
      .8,
    ),
    800: Color.fromRGBO(
      4,
      8,
      17,
      .9,
    ),
    900: Color.fromRGBO(
      4,
      8,
      17,
      1,
    ),
  },
);

ThemeData kAppTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(),
  backgroundColor: const Color(0xff1d2129),
  scaffoldBackgroundColor: const Color(0xff1d2129),
  primaryColor: const Color(0xff040811),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xff040811),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: kPrimaryMaterialColor,    
  ),
  primarySwatch: kPrimaryMaterialColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        const Color(0xff040811),
      ),
    ),
  ),
);
