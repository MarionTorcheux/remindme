import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              iconData: cc.resetPasswordIconData,
              onPressed: () {
                cc.resetPassword();
              },
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
