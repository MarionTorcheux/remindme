import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remindme/core/classes/custom_data.dart';
import 'package:remindme/core/classes/unique_controllers.dart';

import '../../../core/classes/custom_colors.dart';

class CustomFABButton extends StatelessWidget {
  final String tag;
  final String text;
  final Color backgroundColor;
  final Function() onPressed;

  const CustomFABButton({
    super.key,
    required this.tag,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: tag,
      onPressed: onPressed,
      label: Text(text,
          style: UniquesControllers()
              .data
              .textStyleMain(color: CustomColors.mainWhite)),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      extendedPadding: const EdgeInsets.symmetric(horizontal: 130),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
