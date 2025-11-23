import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.tiffanyBlue,
      secondary: AppColors.black,
    ),
    textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
      bodyColor: AppColors.black,
      displayColor: AppColors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.white,
      elevation: 3,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withOpacity(0.06),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.tiffanyBlue,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        elevation: 2,
      ),
    ),
  );
}
