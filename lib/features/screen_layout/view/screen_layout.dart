import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../features/custom_loader/view/custom_loader.dart';

class ScreenLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final Widget body;

  const ScreenLayout({
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButtonLocation: floatingActionButtonLocation,
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
