import 'package:flutter/material.dart';
import '../../../core/classes/custom_colors.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  ThemeData get customTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: CustomColors.mainBlue,
          onPrimary: CustomColors.mainWhite,
          secondary: CustomColors.mainBlue,
          onSecondary: CustomColors.mainBlue,
          error: CustomColors.mainBlue,
          onError: CustomColors.mainBlue,
          surface: CustomColors.mainBlue,
          onSurface: CustomColors.mainBlue,
        ),
        textTheme: const TextTheme(
          displayLarge:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          displayMedium:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          displaySmall:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          headlineLarge:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          headlineMedium:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          headlineSmall:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: 24,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontSize: 12,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      );

  void setCustomTheme() {
    Get.changeTheme(customTheme);
  }
}
