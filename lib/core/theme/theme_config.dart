import 'package:bookify/core/utils/app_colors/app_colors.dart';
import 'package:bookify/core/utils/app_font_size/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: AppColors().primaryColor,
    scaffoldBackgroundColor: AppColors().whiteColor,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: GoogleFonts.lato().toString(),
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.fontSize18,
        color: AppColors().blackColor,
      ),
      displayMedium: TextStyle(
        fontFamily: GoogleFonts.lato().toString(),
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.fontSize18,
        color: AppColors().whiteColor,
      ),
      displaySmall: TextStyle(
        fontFamily: GoogleFonts.lato().toString(),
        fontWeight: FontWeight.w800,
        fontSize: AppFontSize.fontSize14,
        color: AppColors().blackColor,
      ),
      labelSmall: TextStyle(
        fontFamily: GoogleFonts.lato().toString(),
        fontWeight: FontWeight.normal,
        fontSize: AppFontSize.fontSize12,
        color: AppColors().whiteColor,
      ),
      bodySmall: TextStyle(
        fontFamily: GoogleFonts.lato().toString(),
        fontWeight: FontWeight.normal,
        fontSize: AppFontSize.fontSize14,
        color: AppColors().greyColor,
      ),
    ),
  );
}
