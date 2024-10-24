import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storesight/size_config.dart';

ThemeData lightTheme = ThemeData(
  shadowColor: const Color(0xFF171439).withOpacity(0.04),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1D1D1D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    centerTitle: true,
  ),
  primaryColor: const Color(0xFF707070),
  focusColor: const Color(0xFFFFFFFF),
  dividerColor: const Color(0xFFC2C2C2),
  hintColor: const Color(0xFFA8A8A8),
  canvasColor: const Color(0xFFE1E1E1),
  disabledColor: const Color(0xFFFFFFFF),
  primaryColorLight: const Color(0xFFFFFFFF),
  primaryColorDark: const Color(0xFF000000),
  textTheme: GoogleFonts.poppinsTextTheme(),
  scaffoldBackgroundColor: const Color(0xFF1B1B1C),
  cardColor: const Color(0xFF1E1E2C),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFF45C5AF),
  ),
  highlightColor: const Color(0xFF1D1D1D),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF45C5AF),
    primary: const Color(0xFF45C5AF),
    onPrimary: const Color(0xFFFFFFFF),
    secondary: const Color(0xFF1B1B1C),
    primaryContainer: const Color(0xFFB3B3B3),
    onPrimaryContainer: const Color(0xFF1D1D1D),
    secondaryContainer: const Color(0xFF2D2D43),
    onSecondaryContainer: const Color(0xFFF0F0F0),
    errorContainer: const Color(0xFFFF0000),
    tertiary: const Color(0xFFF6C344),
    tertiaryContainer: const Color(0xFF5A5A5A),
    surface: const Color(0xFFFFFFFF),
  ),
);

ThemeData darkTheme = ThemeData(
  shadowColor: const Color(0xFF000000).withOpacity(0.06),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF363636),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    centerTitle: true,
  ),
  primaryColor: const Color(0xFF707070),
  focusColor: const Color(0xFF707070),
  hintColor: const Color(0xFF363636),
  disabledColor: const Color(0xFF5A5A5A),
  dividerColor: const Color(0xFF5A5A5A),
  canvasColor: const Color(0xFF363636),
  primaryColorLight: const Color(0xFF1D1D1D),
  primaryColorDark: const Color(0xFFFFFFFF),
  textTheme: GoogleFonts.poppinsTextTheme(),
  scaffoldBackgroundColor: const Color(0xFF1D1D1D),
  cardColor: const Color(0xFF363636),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFFFFFFFF),
  ),
  highlightColor: const Color(0xFFB3B3B3),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF45C5AF),
    primary: const Color(0xFF45C5AF),
    onPrimary: const Color(0xFFB3B3B3),
    secondary: const Color(0xFF5A5A5A),
    primaryContainer: const Color(0xFFB3B3B3),
    onPrimaryContainer: const Color(0xFF707070),
    secondaryContainer: const Color(0xFF363636),
    onSecondaryContainer: const Color(0xFF5A5A5A),
    errorContainer: const Color(0xFFFF0000),
    tertiary: const Color(0xFFF6C344),
    surface: const Color(0xFF5A5A5A),
    tertiaryContainer: const Color(0xFF5A5A5A),
  ),
);

EdgeInsets padding = EdgeInsets.symmetric(
  horizontal: width(16),
  vertical: height(16),
);

BoxShadow boxShadow = BoxShadow(
  color: theme.shadowColor, //color of shadow
  //spread radius
  blurRadius: 35, // blur radius
  offset: const Offset(0, 20),
);

ThemeData theme = lightTheme;

const baseUrl = "https://retailar.pl/django";
