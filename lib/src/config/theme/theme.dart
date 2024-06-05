import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

ThemeData theme() {
  return ThemeData.light().copyWith(
    // useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    disabledColor: AppColors.disableColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: 'Battambang-Regular',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.appbarColor,
      ),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      // shadowColor: Colors.transparent,
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        fontFamily: 'Battambang-Bold',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.darkColor,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'Battambang-Bold',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.darkColor,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'Battambang-Regular',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.darkColor,
      ),
      titleMedium: const TextStyle(
        fontFamily: 'Battambang-Regular',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.darkColor,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'Battambang-Regular',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.darkColor,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'Battambang-Regular',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.darkColor,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'Battambang-Regular',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.darkColor,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'Battambang-Regular',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000),
      ),
      labelLarge: TextStyle(
        fontFamily: 'Battambang-Bold',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
      ),
    ),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.red,
        onPrimary: AppColors.primaryColor,
        onSecondary: AppColors.secondaryColor,
        onSurface: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        surface: AppColors.primaryColor),
  );
}
