import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../features/custom_app_bar/view/custom_app_bar.dart';
import '../../../core/classes/custom_colors.dart';
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
        title: cc.pageTitle,
        onPressed: () {},
        isautomaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: 300.0,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: SvgPicture.asset(
                  cc.svgImagePath,
                  height: 200,
                ),
              ),
              CustomSpace(heightMultiplier: 2),
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
    );
  }
}
