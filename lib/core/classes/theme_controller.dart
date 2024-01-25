import 'package:flutter/material.dart';
import '../../../core/classes/custom_colors.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  ThemeData get customTheme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: CustomColors.darkPurple,
      onPrimary: CustomColors.eerieBlack,
      inversePrimary: CustomColors.eerieBlack,
      secondary: CustomColors.eerieBlack,
      onSecondary: CustomColors.eerieBlack,
      background: CustomColors.eerieBlack,
      onBackground: CustomColors.eerieBlack,
      error: CustomColors.eerieBlack,
      onError: CustomColors.eerieBlack,
      outline: CustomColors.eerieBlack,
      outlineVariant: CustomColors.eerieBlack,
      shadow: CustomColors.eerieBlack,
      scrim: CustomColors.eerieBlack,
      surface: CustomColors.eerieBlack,
      onSurface: CustomColors.eerieBlack,
      surfaceTint: CustomColors.eerieBlack,
      surfaceVariant: CustomColors.eerieBlack,
      onSurfaceVariant: CustomColors.eerieBlack,
      inverseSurface: CustomColors.eerieBlack,
      onInverseSurface: CustomColors.eerieBlack,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'SpaceGrotesk', fontWeight: FontWeight.w300),
      displayMedium: TextStyle(fontFamily: 'SpaceGrotesk', fontWeight: FontWeight.w300),
      displaySmall: TextStyle(fontFamily: 'SpaceGrotesk', fontWeight: FontWeight.w300),
      headlineLarge: TextStyle(fontFamily: 'LexendDeca', fontWeight: FontWeight.w300),
      headlineMedium: TextStyle(fontFamily: 'LexendDeca', fontWeight: FontWeight.w300),
      headlineSmall: TextStyle(fontFamily: 'LexendDeca', fontWeight: FontWeight.w300),
      titleLarge: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontWeight: FontWeight.w300,
        letterSpacing: 0,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontWeight: FontWeight.w300,
        letterSpacing: 0,
      ),
      bodySmall: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontWeight: FontWeight.w300,
        letterSpacing: 0,
      ),
      labelLarge: TextStyle(
        fontFamily: 'LexendDeca',
        fontWeight: FontWeight.w300,
        letterSpacing: 1.2,
      ),
      labelMedium: TextStyle(
        fontFamily: 'LexendDeca',
        fontWeight: FontWeight.w300,
        letterSpacing: 1.2,
      ),
      labelSmall: TextStyle(
        fontFamily: 'LexendDeca',
        fontWeight: FontWeight.w300,
        letterSpacing: 1.2,
      ),
    ),
  );

  void setCustomTheme() {
    Get.changeTheme(customTheme);
  }
}
