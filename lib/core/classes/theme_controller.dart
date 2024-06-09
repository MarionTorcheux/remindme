import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  ThemeData get customTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: CustomColors.mainWhite,
          onPrimary: CustomColors.mainWhite,
          secondary: CustomColors.mainWhite,
          onSecondary: CustomColors.mainWhite,
          error: CustomColors.mainWhite,
          onError: CustomColors.interaction,
          surface: CustomColors.mainWhite,
          onSurface: CustomColors.darkBlue,
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
            letterSpacing: 0.7,
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
