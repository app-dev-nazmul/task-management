import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.cairo().fontFamily,
    canvasColor: klCanvasColor,
    primaryColor: klPrimaryColor,
    primaryTextTheme: GoogleFonts.cairoTextTheme(),
    textTheme: GoogleFonts.cairoTextTheme(),
    scaffoldBackgroundColor: klPageBackgroundColor,
    appBarTheme: const AppBarTheme(
      color: klBackgroundColorAppbar,
      titleTextStyle: TextStyle(color: kdPrimaryTextColorBlack),
      iconTheme: IconThemeData(color: kdPrimaryTextColorBlack),
    ),

    shadowColor: klPrimaryColor.withOpacity(0.25),
    dividerTheme: _dividerThemeData,
    textButtonTheme: _textButtonTheme,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cupertinoOverrideTheme: _cupertinoOverrideThemeLight,
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll<Color>(klPrimaryTextColor),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: klPrimaryColor).copyWith(
      surface: klBackgroundColor,
      onTertiary: klPrimaryTextColor,
      surfaceTint: Colors.transparent,
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.cairo().fontFamily,
    canvasColor: kdCanvasColor,
    primaryColor: kdPrimaryColor,
    primaryTextTheme: GoogleFonts.cairoTextTheme().apply(
      bodyColor: kdPrimaryTextColorWhite,
      displayColor: kdPrimaryTextColorWhite,
    ),
    textTheme: GoogleFonts.cairoTextTheme().apply(
      bodyColor: kdPrimaryTextColorWhite,
      displayColor: kdPrimaryTextColorWhite,
    ),
    scaffoldBackgroundColor: kdPageBackgroundColor,
    appBarTheme: const AppBarTheme(
      color: kdPageBackgroundAppBarColor,
      titleTextStyle: TextStyle(color: kdPrimaryTextColorWhite),
      iconTheme: IconThemeData(color: kdPrimaryTextColorWhite),
    ),
    shadowColor: kdPrimaryColor.withOpacity(0.25),
    dividerTheme: _dividerThemeData,
    textButtonTheme: _textButtonTheme,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cupertinoOverrideTheme: _cupertinoOverrideThemeDark,
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll<Color>(kdPrimaryTextColorWhite),
    ),
    // colorScheme: ColorScheme.fromSeed(seedColor: kdPrimaryColor).copyWith(
    //   brightness: Brightness.dark,
    //   surface: kdBackgroundColor,
    //   onTertiary: kdPrimaryTextColor,
    //   surfaceTint: Colors.transparent,
    // ),
  ),
};

final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
);

const _dividerThemeData = DividerThemeData(
  color: Colors.black12,
  thickness: 0.5,
);

// Cupertino Overrides
final _cupertinoOverrideThemeLight = const CupertinoThemeData(
  primaryColor: klPrimaryColor,
  scaffoldBackgroundColor: klPageBackgroundColor,
);

final _cupertinoOverrideThemeDark = const CupertinoThemeData(
  primaryColor: kdPrimaryColor,
  scaffoldBackgroundColor: kdPageBackgroundColor,
);
