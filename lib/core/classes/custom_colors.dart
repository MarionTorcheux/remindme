import 'package:flutter/material.dart';

class CustomColors {
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter, // Commence par le haut
    end: Alignment(0.0, 0.6), // Termine à 60% de la hauteur de l'écran
    colors: [mainWhite, mainBlue],
  );

  static const Color mainWhite = Color(0xFFF8F8F8);
  static const Color darkBlue = Color(0xFF2D3A53);
  static const Color shadowBlue = Color(0xFF1B72BB);
  static const Color blueButton = Color(0xFF29B6F6);
  static const Color interaction = Color(0xFFB21C1C);
  static const Color mainBlue = Color(0xFF2389C2);
}
