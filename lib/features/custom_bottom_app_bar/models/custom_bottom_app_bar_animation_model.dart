import 'package:flutter/material.dart';

class CustomBottomAppBarAnimationModel {
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final double yStartPosition;
  final bool isOpacity;

  CustomBottomAppBarAnimationModel({
    required this.backgroundColor,
    required this.animationDuration,
    required this.animationCurve,
    required this.yStartPosition,
    required this.isOpacity,
  });
}
