import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/core/classes/custom_colors.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';
import 'package:remindme/features/custom_text_form_field/view/custom_text_form_field.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';

import '../../../features/custom_divider/view/custom_divider.dart';
import '../../../features/custom_fab_button/view/custom_fab_button.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../../../features/custom_text_button/view/custom_text_button.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoginScreenController cc = Get.put(
      LoginScreenController(),
      tag: 'login_screen',
      permanent: true,
    );


    return ScreenLayout(
      appBar:  CustomAppBar(
        title: Text(cc.pageTitle,
        style: TextStyle(
            color: CustomColors.seasalt,
          ),
        ),
        tag: 'login-screen',

        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              tag: cc.emailTag,
              controller: cc.emailController,
              labelText: cc.emailLabel,
              errorText: cc.emailError,
              riveAnimation: cc.emailRiveAnimation,
              keyboardType: cc.emailInputType,
              onChanged: (value) {
                cc.emailController.text = value;
              },
            ),
            const CustomSpace(heightMultiplier: 2),
            CustomTextFormField(
              tag: cc.passwordTag,
              controller: cc.passwordController,
              labelText: cc.passwordLabel,
              errorText: cc.passwordError,
              riveAnimation: cc.passwordRiveAnimation,
              keyboardType: cc.passwordInputType,
              isPassword: true,
            ),
            const CustomSpace(heightMultiplier: 1),
            SizedBox(
              width: cc.maxWith,
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  tag: cc.forgotPasswordTag,
                  text: cc.forgotPasswordLabel,
                  onPressed: () {
                  },
                ),
              ),
            ),
            const CustomSpace(heightMultiplier: 4),
            CustomFABButton(
              tag: cc.connectionTag,
              text: cc.connectionLabel,
              backgroundColor: CustomColors.seasalt,
              onPressed: () {
                cc.login();
              },
            ),
            const CustomSpace(heightMultiplier: 2),
            CustomDivider(
              tag: 'divider',
              text: cc.dividerLabel,
              width: cc.dividerWidth,
            ),
            const CustomSpace(heightMultiplier: 2),
            CustomFABButton(
              tag: cc.registerTag,
              text: cc.registerLabel,
              backgroundColor: CustomColors.seasalt,
              onPressed: () {
                cc.registerScreenOnPressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}