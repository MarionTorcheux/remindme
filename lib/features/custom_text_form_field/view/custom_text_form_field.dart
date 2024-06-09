import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../controllers/custom_text_form_field_controller.dart';

class CustomTextFormField extends StatelessWidget {
  final String tag;

  final TextEditingController controller;

  final String labelText;
  final String? errorText;
  final IconData? iconData;
  final bool? isPassword;
  final TextInputType? keyboardType;

  final String? validatorPattern;
  final String? Function(String?)? validator;
  final bool? isNullable;
  final bool? enabled;

  final int? minLines;
  final int? maxLines;
  final bool? unlimitedLines;

  final Color? labelTextColor;

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.tag,
    required this.controller,
    required this.labelText,
    this.errorText,
    this.iconData,
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
    this.labelTextColor,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: UniquesControllers()
                .data
                .textStyleMain(color: labelTextColor ?? CustomColors.mainWhite),
          ),
          const CustomSpace(heightMultiplier: 0.5),
          Obx(
            () => PhysicalModel(
              color: CustomColors.interaction,
              borderRadius: BorderRadius.circular(10),
              elevation: 3.0,
              shadowColor: Colors.black,
              child: TextFormField(
                cursorColor: CustomColors.mainBlue,
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
                      return errorText ?? "Ce champ est vide";
                    } else if (!RegExp(validatorPattern!).hasMatch(value)) {
                      return errorText ?? "Ce champ est invalide";
                    }
                  } else {
                    if (value! == "" && isNullable == false) {
                      return errorText ?? "Ce champ est vide";
                    }
                  }

                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: CustomColors.mainWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
