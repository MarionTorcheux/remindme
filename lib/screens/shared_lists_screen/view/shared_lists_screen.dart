import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';
import 'package:remindme/features/custom_space/view/custom_space.dart';
import 'package:remindme/features/custom_text_button/view/custom_text_button.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
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
        title: 'Listes partagées',
        onPressed: () {},
        isautomaticallyImplyLeading: true,
      ),
      bottomNavigationBar: CustomBottomAppBar(
        tag: "bottomAppBar",
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: CustomColors.backgroundGradient,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Vous n\'avez pas encore de listes partagées',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center),
                CustomSpace(heightMultiplier: 5),
                Image.asset('images/deadfish.png'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
