import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../controllers/custom_app_bar_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isautomaticallyImplyLeading;
  final IconData? iconData;
  final Function() onPressed;

  CustomAppBar({
    super.key,
    required this.title,
    this.isautomaticallyImplyLeading = false,
    this.iconData,
    required this.onPressed,
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
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        if (iconData != null)
          IconButton(
            icon: Icon(iconData),
            onPressed: onPressed,
          ),
      ],
    );
  }
}
