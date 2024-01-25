import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/custom_bottom_app_bar_controller.dart';
import '../models/custom_bottom_app_bar_icon_button_model.dart';

class CustomBottomAppBar extends StatelessWidget {
  final String tag;
  final RxList<CustomBottomAppBarIconButtonModel> iconModelList;

  const CustomBottomAppBar({
    super.key,
    required this.tag,
    required this.iconModelList,
  });

  @override
  Widget build(BuildContext context) {
    CustomBottomAppBarController cc = Get.put(
      CustomBottomAppBarController(
        iconModelList: iconModelList,
      ),
      tag: tag,
      permanent: true,
    );

    return BottomAppBar(
      color: cc.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: cc.bottomAppBarChildren,
      ),
    );
  }
}
