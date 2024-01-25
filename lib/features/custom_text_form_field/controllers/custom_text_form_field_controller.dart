import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class CustomTextFormFieldController extends GetxController {

  double maxWith = 350.0;
  RxBool isObscure = false.obs;

  FocusNode? focusNode;

  void initIsPassword(bool? isPassword) {
    if (isPassword != null) {
      isObscure.value = isPassword;
    }
  }

}
