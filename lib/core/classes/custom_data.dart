import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/custom_bottom_app_bar/models/custom_bottom_app_bar_icon_button_model.dart';
import '../../features/custom_icon_button/view/custom_icon_button.dart';
import '../../features/custom_loader/view/custom_loader.dart';
import '../routes/app_routes.dart';
import 'custom_colors.dart';

class CustomData extends GetxController {
  RxBool isInAsyncCall = false.obs;

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  double baseSpace = 8;
  double baseAppBarHeight = 56;
  Duration baseAnimationDuration = const Duration(milliseconds: 400);
  Curve baseAnimationCurve = Curves.easeOut;

  TextStyle titleTextStyle = const TextStyle(
    fontSize: 18,
    letterSpacing: 1.5,
    wordSpacing: 2,
    fontWeight: FontWeight.bold,
  );

  RxList<CustomBottomAppBarIconButtonModel> mainIconList = <CustomBottomAppBarIconButtonModel>[
    CustomBottomAppBarIconButtonModel(
      tag: Routes.tasks,
      iconData: Icons.list,
      iconColor: CustomColors.seasalt,
      onPressed: () => Get.offNamed(Routes.tasks),
    ),
  ].obs;

  Widget get backButton => CustomIconButton(
    tag: 'backButton',
    iconData: Icons.arrow_back_outlined,
    iconColor: CustomColors.seasalt,
    onPressed: Get.back,
  );

  Widget loader() {
    return const Center(
      child: CustomLoader(
        color: CustomColors.seasalt,
      ),
    );
  }

  void snackbar(String title, String message, bool error) {
    Get.snackbar(
      title,
      message,
      icon: error
          ? const Icon(
        Icons.error,
        color: CustomColors.eerieBlack,
      )
          : const Icon(
        Icons.check_circle,
        color: CustomColors.eerieBlack,
      ),
      maxWidth: 600,
      borderWidth: baseSpace / 2,
      isDismissible: true,
      margin: EdgeInsets.symmetric(
        vertical: baseSpace * 2,
        horizontal: baseSpace * 2,
      ),
      duration: const Duration(seconds: 5),
      borderColor: CustomColors.eerieBlack,
      colorText: CustomColors.eerieBlack,
      backgroundColor: CustomColors.seasalt,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text(
          'OK',
          style: TextStyle(
            color: CustomColors.eerieBlack,
          ),
        ),
      ),
      snackPosition: SnackPosition.TOP,
    );
  }

  void uploadImage({required Function(File file) onSelected, onAbort}) {
    InputElement uploadInput = FileUploadInputElement() as InputElement..accept = 'image/*';

    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);

      reader.addEventListener('click', (event) {});
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
      reader.onAbort.listen((event) {
        onAbort();
      });
    });
  }
}
