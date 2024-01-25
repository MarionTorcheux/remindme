import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';
import '../../custom_animation/view/custom_animation.dart';
import '../../custom_icon_button/view/custom_icon_button.dart';
import '../models/custom_bottom_app_bar_animation_model.dart';
import '../models/custom_bottom_app_bar_icon_button_model.dart';

class CustomBottomAppBarIconButton extends StatelessWidget {
  final String tag;
  final Duration delay;
  final CustomBottomAppBarAnimationModel animationModel;
  final CustomBottomAppBarIconButtonModel iconModel;

  const CustomBottomAppBarIconButton({
    super.key,
    required this.tag,
    required this.delay,
    required this.animationModel,
    required this.iconModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimation(
      tag: tag,
      delay: delay,
      duration: animationModel.animationDuration,
      yStartPosition: animationModel.yStartPosition,
      isOpacity: animationModel.isOpacity,
      curve: animationModel.animationCurve,
      child: CustomIconButton(
        tag: tag,
        iconData: iconModel.iconData,
        iconColor: iconModel.tag == Get.currentRoute ? CustomColors.seasalt : iconModel.iconColor,
        backgroundColor: iconModel.tag == Get.currentRoute ? CustomColors.eerieBlack : null,
        onPressed: iconModel.onPressed,
      ),
    );
  }
}
