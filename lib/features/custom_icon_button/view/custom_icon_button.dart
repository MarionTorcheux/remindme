import 'package:flutter/material.dart';

import '../../../core/classes/custom_colors.dart';

class CustomIconButton extends StatelessWidget {
  final String tag;
  final IconData? iconData;
  final Color? iconColor;
  final Color? backgroundColor;
  final Function() onPressed;

  const CustomIconButton({
    super.key,
    required this.tag,
    this.iconData,
    this.iconColor,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          backgroundColor ?? Colors.transparent,
        ),
      ),
      icon: Icon(
        iconData,
        color: iconColor ??  CustomColors.mainBlue,
      ),
      onPressed: onPressed,
    );
  }
}
