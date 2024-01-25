import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../core/classes/theme_controller.dart';
import '../controllers/custom_text_form_field_controller.dart';

class CustomTextFormField extends StatelessWidget {
  final String tag;

  final TextEditingController controller;

  final String labelText;
  final String? hintText;
  final String? errorText;
  final IconData? iconData;
  final String? riveAnimation;
  final bool? isPassword;
  final TextInputType? keyboardType;

  final String? validatorPattern;
  final String? Function(String?)? validator;
  final bool? isNullable;
  final bool? enabled;

  final int? minLines;
  final int? maxLines;
  final bool? unlimitedLines;

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.tag,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.errorText,
    this.iconData,
    this.riveAnimation,
    this.isPassword,
    this.keyboardType,
    this.validatorPattern,
    this.validator,
    this.isNullable,
    this.enabled,
    this.minLines,
    this.maxLines,
    this.unlimitedLines,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    CustomTextFormFieldController cc = Get.put(
      CustomTextFormFieldController(),
      tag: tag,
      permanent: true,
    );

    cc.initIsPassword(isPassword);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: cc.maxWith,
      ),
      child: Obx(
            () => TextFormField(
          focusNode: cc.focusNode,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          enabled: enabled ?? true,
          obscureText: cc.isObscure.value,
          minLines: minLines ?? 1,
          maxLines: unlimitedLines ?? false ? null : maxLines ?? 1,
          onFieldSubmitted: onFieldSubmitted,
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            } else if (validatorPattern != null) {
              if (value!.isEmpty) {
                return errorText ?? "Ce champs est vide";
              } else if (!RegExp(validatorPattern!).hasMatch(value)) {
                return errorText ?? "Ce champs est invalide";
              }
            } else {
              if (value! == "" && isNullable == false) {
                return errorText ?? "Ce champs est vide";
              }
            }

            return null;
          },
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}