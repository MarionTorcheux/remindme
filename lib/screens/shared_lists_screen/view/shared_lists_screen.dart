import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';
import 'package:remindme/features/custom_space/view/custom_space.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../features/custom_bottom_app_bar/view/custom_bottom_app_bar.dart';
import '../controllers/shared_lists_screen_controller.dart';

class SharedListsScreen extends StatelessWidget {
  const SharedListsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SharedListsScreenController cc = Get.put(
      SharedListsScreenController(),
      tag: 'shared_screen',
      permanent: true,
    );

    return ScreenLayout(
      appBar: CustomAppBar(
        title: cc.titleSharedListsScreen,
        onPressed: () {},
        isLeadingWithCustomArrow: true,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: cc.tagBottomAppBarSharedListsScreen,
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(cc.textNoSharedLists,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                  CustomSpace(heightMultiplier: 5),
                  SvgPicture.asset(
                    cc.svgPicturePath,
                    width: 150,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
