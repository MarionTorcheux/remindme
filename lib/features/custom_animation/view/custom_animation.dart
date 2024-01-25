import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/custom_animation_controller.dart';

class CustomAnimation extends StatelessWidget {
  final String tag;
  final Widget child;
  final Duration? duration;
  final Curve? curve;
  final Duration? delay;
  final bool? isOpacity;
  final bool? isScale;
  final double? xStartPosition;
  final double? yStartPosition;
  final double? zStartPosition;

  const CustomAnimation({
    super.key,
    required this.tag,
    required this.child,
    this.duration,
    this.curve,
    this.delay,
    this.isOpacity,
    this.isScale,
    this.xStartPosition,
    this.yStartPosition,
    this.zStartPosition,
  });

  @override
  Widget build(BuildContext context) {
    CustomAnimationController cc = Get.put(
      CustomAnimationController(
        delay: delay,
        xStartPosition: xStartPosition,
        yStartPosition: yStartPosition,
        zStartPosition: zStartPosition,
      ),
      tag: tag,
    );

    return Obx(
          () => AnimatedOpacity(
        opacity: isOpacity ?? false ? cc.opacity.value : 1,
        duration: duration ?? cc.baseDuration,
        curve: curve ?? cc.baseCurve,
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          duration: duration ?? cc.baseDuration,
          curve: curve ?? cc.baseCurve,
          transform: Matrix4.translationValues(
            cc.xTranslation.value,
            cc.yTranslation.value,
            cc.zTranslation.value,
          )..scale(isScale ?? false ? cc.scale.value : 1),
          child: child,
        ),
      ),
    );
  }
}
