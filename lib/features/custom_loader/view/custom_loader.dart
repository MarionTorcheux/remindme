import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';

class CustomLoaderController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class CustomLoader extends StatelessWidget {
  final double? size;
  final Color? color;

  CustomLoader({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key) {
    Get.put(CustomLoaderController());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShaderMask(
        shaderCallback: (bounds) => material.LinearGradient(
          colors: [color ?? Colors.white, color ?? Colors.white],
          stops: const [0.0, 1.0],
        ).createShader(bounds),
        child: SizedBox(
          width: size ?? 120,
          height: size ?? 120,
          child: GetBuilder<CustomLoaderController>(
            builder: (controller) {
              return RotationTransition(
                turns: controller.animationController,
                child: material.Icon(
                  Icons.refresh,
                  size: size ?? 120,
                  color: CustomColors.mainWhite,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
