import 'package:flutter/material.dart';
import '../../../features/custom_bottom_app_bar/models/custom_bottom_app_bar_animation_model.dart';
import 'package:get/get.dart';

import '../../../core/classes/custom_colors.dart';
import '../../custom_space/view/custom_space.dart';
import '../models/custom_bottom_app_bar_icon_button_model.dart';
import '../widgets/custom_bottom_app_bar_icon_button.dart';

class CustomBottomAppBarController extends GetxController {
  final RxList<CustomBottomAppBarIconButtonModel> iconModelList;

  CustomBottomAppBarController({
    required this.iconModelList,
  });

  RxList<Widget> bottomAppBarChildren = <Widget>[].obs;

  Color iconColor = CustomColors.seasalt;

  Color backgroundColor = CustomColors.eerieBlack;
  Duration animationDuration = const Duration(milliseconds: 400);
  Duration animationDelay(int index) => Duration(milliseconds: 100 * index);
  Curve animationCurve = Curves.easeInOutBack;
  double yStartPosition = 40;
  bool isOpacity = true;

  CustomBottomAppBarAnimationModel get animationModel => CustomBottomAppBarAnimationModel(
    backgroundColor: backgroundColor,
    animationDuration: animationDuration,
    animationCurve: animationCurve,
    yStartPosition: yStartPosition,
    isOpacity: isOpacity,
  );

  void defineBottomAppBarChildren() {
    for (int i = 0; i < iconModelList.length; i++) {
      bottomAppBarChildren.add(
        CustomBottomAppBarIconButton(
          tag: iconModelList[i].tag,
          delay: animationDelay(i),
          animationModel: animationModel,
          iconModel: iconModelList[i],
        ),
      );
      bottomAppBarChildren.add(
        const CustomSpace(widthMultiplier: 2),
      );
    }
  }

  @override
  void onInit() {
    defineBottomAppBarChildren();
    super.onInit();
  }
}
