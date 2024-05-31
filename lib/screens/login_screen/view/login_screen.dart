import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/core/classes/custom_colors.dart';
import 'package:remindme/features/custom_text_form_field/view/custom_text_form_field.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/unique_controllers.dart';
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
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: CustomColors.backgroundGradient,
          ),
          child: Center(
            child: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image.asset(
                      'images/logintop.png',
                    ),
                  ),
                  CustomTextFormField(
                    tag: cc.emailTag,
                    controller: cc.emailController,
                    labelText: cc.emailLabel,
                    errorText: cc.emailError,
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
                        color: CustomColors.mainWhite,
                        onPressed: () {
                          cc.passwordScreenOnPressed();
                        },
                      ),
                    ),
                  ),
                  const CustomSpace(heightMultiplier: 4),
                  CustomFABButton(
                    tag: cc.connectionTag,
                    text: cc.connectionLabel,
                    backgroundColor: CustomColors.blueButton,
                    onPressed: () {
                      cc.login();
                    },
                  ),
                  const CustomSpace(heightMultiplier: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pas encore de compte ?",
                          style: UniquesControllers()
                              .data
                              .textStyleMain(color: CustomColors.mainWhite)),
                      CustomTextButton(
                          tag: "createButton",
                          text: "Créer",
                          onPressed: () {
                            cc.registerScreenOnPressed();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
