import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/custom_icon_button/view/custom_icon_button.dart';
import '../../features/custom_loader/view/custom_loader.dart';
import '../routes/app_routes.dart';
import 'custom_colors.dart';

class CustomData extends GetxController {
  RxBool isInAsyncCall = false.obs;
  RxBool isEditMode = false.obs;
  RxString? selectedListId = ''.obs;

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  double baseSpace = 8;
  double baseAppBarHeight = 56;

  void cleanListVar() {
    selectedListId!.value = '';
    isEditMode.value = false;
  }

  TextStyle textStyleMain({required Color color}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget get backButton => CustomIconButton(
        tag: 'backButton',
        iconData: Icons.arrow_back_outlined,
        iconColor: CustomColors.mainBlue,
        onPressed: Get.back,
      );

  Widget loader() {
    return const Center(
      child: CustomLoader(
        color: CustomColors.mainBlue,
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
              color: CustomColors.mainWhite,
            )
          : const Icon(
              Icons.check_circle,
              color: CustomColors.mainWhite,
            ),
      maxWidth: 600,
      borderWidth: baseSpace / 2,
      isDismissible: true,
      margin: EdgeInsets.symmetric(
        vertical: baseSpace * 2,
        horizontal: baseSpace * 2,
      ),
      duration: const Duration(seconds: 5),
      borderColor: CustomColors.mainBlue,
      colorText: CustomColors.mainWhite,
      backgroundColor: CustomColors.mainBlue,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text(
          'OK',
          style: TextStyle(
            color: CustomColors.mainWhite,
          ),
        ),
      ),
      snackPosition: SnackPosition.TOP,
    );
  }

  void back() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      Future.delayed(const Duration(milliseconds: 1000)).then(
        (_) {
          closeDialogAndBottomSheet();
        },
      );
    } else {
      closeDialogAndBottomSheet();
    }
  }

  void closeDialogAndBottomSheet() {
    if (Get.isDialogOpen!) Get.back();
    if (Get.isBottomSheetOpen!) Get.back();
  }
}
