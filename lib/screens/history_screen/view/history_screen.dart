import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/custom_app_bar/view/custom_app_bar.dart';
import '../../../features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../features/custom_bottom_app_bar/view/custom_bottom_app_bar.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../../../screens/history_screen/controllers/history_screen_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HistoryScreenController cc = Get.put(
      HistoryScreenController(),
      tag: 'history_screen',
      permanent: true,
    );

    return ScreenLayout(
      appBar: CustomAppBar(
        isLeadingWithCustomArrow: true,
        title: cc.titleHistoryScreen,
        onPressed: () {},
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: cc.tagBottomAppBarHistoryScreen,
      ),
      body: Stack(
        children: [
          const CustomSpace(heightMultiplier: 4),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cc.textNoHistory,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center),
                CustomSpace(heightMultiplier: 5),
                Icon(Icons.history, size: 80, color: CustomColors.darkBlue),
              ],
            ),
          )
        ],
      ),
    );
  }
}
