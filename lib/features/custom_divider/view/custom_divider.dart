import 'package:flutter/material.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../features/custom_divider/controllers/custom_divider_controller.dart';
import 'package:get/get.dart';

class CustomDivider extends StatelessWidget {
  final String tag;
  final String? text;
  final double? width;
  final Color? dividerColor;
  final double? dividerThickness;
  final double? dividerPaddingMultiplier;
  final Color? dividerTextColor;

  const CustomDivider({
    super.key,
    required this.tag,
    this.text,
    this.width,
    this.dividerColor,
    this.dividerThickness,
    this.dividerPaddingMultiplier,
    this.dividerTextColor,
  });

  @override
  Widget build(BuildContext context) {
    CustomDividerController cc = Get.put(
      CustomDividerController(),
      tag: tag,
      permanent: true,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: width ?? double.infinity,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: dividerColor ??  CustomColors.mainBlue,
              thickness: dividerThickness ?? cc.dividerThickness,
            ),
          ),
          if (text != null)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                UniquesControllers().data.baseSpace * (dividerPaddingMultiplier ?? cc.dividerPaddingMultiplier),
              ),
              child: Text(
                text!,
                style: TextStyle(
                  color: dividerTextColor ??  CustomColors.mainBlue,
                ),
              ),
            ),
          if (text != null)
            Expanded(
              child: Divider(
                color: dividerColor ??  CustomColors.mainBlue,
                thickness: dividerThickness ?? cc.dividerThickness,
              ),
            ),
        ],
      ),
    );
  }
}
