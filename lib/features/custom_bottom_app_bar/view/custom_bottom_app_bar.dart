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
    CustomBottomAppBarController cc = Get.put(
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
              color: CustomColors.darkBlue,
              size: 30,
            ),
            onPressed: () {
              Get.offNamed(Routes.lists);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: CustomColors.darkBlue,
              size: 30,
            ),
            onPressed: () {
              Get.offNamed(Routes.sharedlists);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.schedule,
              color: CustomColors.darkBlue,
              size: 30,
            ),
            onPressed: () {
              Get.offNamed(Routes.history);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: CustomColors.darkBlue,
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
}
