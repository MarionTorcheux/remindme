import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../features/custom_loader/view/custom_loader.dart';

class ScreenLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget body;
  final Gradient? gradient;

  const ScreenLayout({
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.gradient,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
            decoration:
                BoxDecoration(gradient: CustomColors.backgroundGradient),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            body: body,
          ),
          Visibility(
            visible: UniquesControllers().data.isInAsyncCall.value,
            child: Container(
              color: CustomColors.mainBlue.withOpacity(0.9),
              width: Get.width,
              height: Get.height,
              child: const CustomLoader(),
            ),
          ),
        ],
      ),
    );
  }
}
