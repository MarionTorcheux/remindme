import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../features/custom_fab_button/view/custom_fab_button.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../../../features/custom_text_form_field/view/custom_text_form_field.dart';
import '../../../features/screen_layout/view/screen_layout.dart';
import '../controllers/password_screen_controller.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PasswordScreenController cc = Get.put(
      PasswordScreenController(),
      tag: 'password-screen',
      permanent: true,
    );

    return ScreenLayout(
      appBar: CustomAppBar(
        title: 'Mot de passe oublié',
        onPressed: () {
          Get.back();
        },
        isautomaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomColors.backgroundGradient,
        ),
        child: Center(
          child: Container(
            width: 300.0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    'images/forgotFish.png',
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      tag: cc.emailTag,
                      controller: cc.emailController,
                      labelText: cc.emailLabel,
                      errorText: cc.emailError,
                      iconData: cc.emailIconData,
                    ),
                    const CustomSpace(heightMultiplier: 4),
                    CustomFABButton(
                      tag: cc.resetPasswordTag,
                      text: cc.resetPasswordLabel,
                      onPressed: () {
                        cc.resetPassword();
                      },
                      backgroundColor: CustomColors.blueButton,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
