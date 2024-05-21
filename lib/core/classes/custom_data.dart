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

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  double baseSpace = 8;
  double baseAppBarHeight = 56;
  Duration baseAnimationDuration = const Duration(milliseconds: 400);
  Curve baseAnimationCurve = Curves.easeOut;

  TextStyle textStyleMain({Color color = CustomColors.mainWhite}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 18,
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
}
