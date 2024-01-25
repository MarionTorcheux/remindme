import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../features/custom_loader/view/custom_loader.dart';

class ScreenLayout extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Drawer? drawer;
  final Widget body;
  final bool? showVersion;

  const ScreenLayout({
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    required this.body,
    this.showVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Stack(
        children: [
          Scaffold(
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            drawer: drawer,
            body: body,
          ),
          Visibility(
            visible: UniquesControllers().data.isInAsyncCall.value,
            child: Container(
              color: CustomColors.eerieBlack.withOpacity(0.9),
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
