import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remindme/core/classes/custom_colors.dart';

import '../../../core/classes/theme_controller.dart';

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
    this.fontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    // final CustomTextButtonController cc = Get.put(
    //   CustomTextButtonController(),
    //   tag: tag,
    // );

    final baseColor = color ?? CustomColors.interaction;

    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: baseColor, // Text color
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: fontSize, fontWeight: FontWeight.w600),
        ));
  }
}
