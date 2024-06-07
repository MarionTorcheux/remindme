import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';

import '../../../core/routes/app_routes.dart';
import '../controllers/custom_app_bar_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isautomaticallyImplyLeading;
  final bool isLeadingWithCustomArrow;
  final IconData? iconData;
  final Function() onPressed;

  CustomAppBar({
    super.key,
    required this.title,
    this.isautomaticallyImplyLeading = false,
    this.iconData,
    required this.onPressed,
    this.isLeadingWithCustomArrow = false,
    // required IconButton leading,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    CustomAppBarController cc = Get.put(
      CustomAppBarController(),
    );

    return AppBar(
      automaticallyImplyLeading: isautomaticallyImplyLeading,
      backgroundColor: CustomColors.mainBlue,
      leading: isLeadingWithCustomArrow
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.offNamed(Routes.lists);
              },
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: CustomColors.mainWhite,
          fontSize: 20,
        ),
      ),
      actions: [
        if (iconData != null)
          IconButton(
            color: CustomColors.mainWhite,
            icon: Icon(iconData),
            onPressed: onPressed,
          ),
      ],
    );
  }
}
