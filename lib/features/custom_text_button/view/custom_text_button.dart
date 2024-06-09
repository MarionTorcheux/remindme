import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/classes/custom_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String tag;
  final String text;
  final Color? color;
  final IconData? iconData;
  final Function() onPressed;
  final double fontSize;

  const CustomTextButton({
    super.key,
    required this.tag,
    required this.text,
    this.color,
    this.iconData,
    required this.onPressed,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? CustomColors.interaction;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: baseColor,
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: fontSize, fontWeight: FontWeight.w600),
      ),
    );
  }
}
