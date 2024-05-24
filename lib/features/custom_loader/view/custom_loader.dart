import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../core/classes/custom_colors.dart';

class CustomLoader extends StatelessWidget {
  final double? size;
  final Color? color;

  const CustomLoader({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShaderMask(
        shaderCallback: (bounds) => material.LinearGradient(
          colors: [color ?? Colors.white, color ?? Colors.white],
          stops: const [0.0, 1.0],
        ).createShader(bounds),
        child: SizedBox(
          width: size ?? 120,
          height: size ?? 120,
          child: material.Icon(
            Icons.refresh,
            size: size ?? 120,
            color: CustomColors.mainWhite,
          ),
        ),
      ),
    );
  }
}
