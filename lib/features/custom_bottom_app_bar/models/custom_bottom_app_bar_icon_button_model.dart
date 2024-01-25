import 'package:flutter/material.dart';

class CustomBottomAppBarIconButtonModel {
  final String tag;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onPressed;

  CustomBottomAppBarIconButtonModel({
    required this.tag,
    required this.iconData,
    required this.iconColor,
    required this.onPressed,
  });
}
