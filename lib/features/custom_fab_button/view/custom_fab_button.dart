import 'package:flutter/material.dart';

class CustomFABButton extends StatelessWidget {
  final String tag;
  final String text;
  final IconData? iconData;
  final Color backgroundColor;
  final Function() onPressed;

  const CustomFABButton({
    super.key,
    required this.tag,
    required this.text,
    this.iconData,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // final CustomFABButtonController cc = Get.put(
    //   CustomFABButtonController(),
    //   tag: tag,
    // );

    return FloatingActionButton.extended(
      heroTag: tag,
      onPressed: onPressed,
      label: Text(text),
      backgroundColor: backgroundColor,
      icon: iconData != null ? Icon(iconData) : null,
    );
  }
}
