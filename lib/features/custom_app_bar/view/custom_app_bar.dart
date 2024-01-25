import 'package:flutter/material.dart';
import '../../../features/custom_animation/view/custom_animation.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String tag;
  final Widget? leading;
  final double? leadingWidgetNumber;
  final Widget? title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.tag,
    this.leading,
    this.leadingWidgetNumber,
    this.title,
    this.actions,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return CustomAnimation(
      tag: tag,
      duration: UniquesControllers().data.baseAnimationDuration,
      delay: UniquesControllers().data.baseAnimationDuration,
      curve: UniquesControllers().data.baseAnimationCurve,
      yStartPosition: -UniquesControllers().data.baseAppBarHeight,
      isOpacity: true,
      child: AppBar(
        centerTitle: true,
        leadingWidth: leadingWidgetNumber == null
            ? UniquesControllers().data.baseAppBarHeight
            : UniquesControllers().data.baseAppBarHeight * leadingWidgetNumber!,
        leading: leading ?? Container(),
        title: title,
        actions: actions,
        backgroundColor: CustomColors.darkGray,
      ),
    );
  }
}
