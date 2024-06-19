import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../controllers/custom_bottom_app_bar_controller.dart';

class CustomBottomAppBar extends StatelessWidget {
  final String tag;

  const CustomBottomAppBar({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final CustomBottomAppBarController cc = Get.put(
      CustomBottomAppBarController(),
      tag: tag,
    );

    return BottomAppBar(
      color: CustomColors.mainWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: _getIconColor(cc, Routes.lists),
              size: 30,
            ),
            onPressed: () {
              Get.offNamed(Routes.lists);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: _getIconColor(cc, Routes.sharedlists),
              size: 30,
            ),
            onPressed: () {
              Get.offNamed(Routes.sharedlists);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.schedule,
              color: _getIconColor(cc, Routes.history),
              size: 30,
            ),
            onPressed: () {
              Get.offNamed(Routes.history);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: _getIconColor(cc, Routes.profile),
              size: 30,
            ),
            onPressed: () {
              Get.offNamed(Routes.profile);
            },
          ),
        ],
      ),
    );
  }

  Color _getIconColor(CustomBottomAppBarController cc, String route) {
    return cc.currentRoute == route ? CustomColors.darkBlue : Colors.grey;
  }
}
