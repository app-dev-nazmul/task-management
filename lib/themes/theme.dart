import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

enum AppTheme { light }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: AppColors.primary,
    primaryTextTheme: GoogleFonts.poppinsTextTheme(),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.disableTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),
    ),
    scaffoldBackgroundColor: AppColors.background,
    textButtonTheme: _textButtonTheme,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  ),
};

final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
);
