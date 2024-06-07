import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/features/custom_app_bar/view/custom_app_bar.dart';
import '../../../core/classes/custom_colors.dart';
import '../../../features/custom_fab_button/view/custom_fab_button.dart';
import '../../../features/custom_icon_button/view/custom_icon_button.dart';
import '../../../features/custom_space/view/custom_space.dart';
import '../../../features/custom_text_form_field/view/custom_text_form_field.dart';
import '../../../features/screen_layout/view/screen_layout.dart';
import '../controllers/register_screen_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterScreenController cc = Get.put(
      RegisterScreenController(),
      tag: 'register-screen',
      permanent: false,
    );

    return ScreenLayout(
      appBar: CustomAppBar(
        isautomaticallyImplyLeading: true,
        title: 'Créer un compte',
        onPressed: () {},
      ),
      body: Center(
        child: Form(
          key: cc.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => PhysicalModel(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(70),
                    elevation: 3.0,
                    shadowColor: Colors.black,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: CustomColors.mainWhite,
                      backgroundImage: cc.selectedImagePath.value.isNotEmpty
                          ? FileImage(File(cc.selectedImagePath.value))
                          : null,
                      child: cc.selectedImagePath.value.isNotEmpty
                          ? null
                          : CustomIconButton(
                              tag: "register-picture",
                              iconData: Icons.add_a_photo_outlined,
                              onPressed: () {
                                cc.pickFiles();
                              },
                            ),
                    ),
                  ),
                ),
                const CustomSpace(heightMultiplier: 2),
                const Text(
                  'Photo de profil',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: CustomColors.mainWhite,
                      fontFamily: 'Poppins'),
                ),
                CustomTextFormField(
                  tag: cc.nameTag,
                  controller: cc.nameController,
                  labelText: cc.nameLabel,
                  errorText: cc.nameError,
                  iconData: cc.nameIconData,
                  keyboardType: cc.nameInputType,
                  validatorPattern: cc.nameValidatorPattern,
                ),
                const CustomSpace(heightMultiplier: 2),
                CustomTextFormField(
                  tag: cc.emailTag,
                  controller: cc.emailController,
                  labelText: cc.emailLabel,
                  errorText: cc.emailError,
                  iconData: cc.emailIconData,
                  keyboardType: cc.emailInputType,
                  validatorPattern: cc.emailValidatorPattern,
                ),
                const CustomSpace(heightMultiplier: 2),
                CustomTextFormField(
                  tag: cc.passwordTag,
                  controller: cc.passwordController,
                  labelText: cc.passwordLabel,
                  errorText: cc.passwordError,
                  iconData: cc.passwordIconData,
                  isPassword: true,
                  keyboardType: cc.passwordInputType,
                  validatorPattern: cc.passwordValidatorPattern,
                ),
                const CustomSpace(heightMultiplier: 2),
                CustomTextFormField(
                  tag: cc.confirmPasswordTag,
                  controller: cc.confirmPasswordController,
                  labelText: cc.confirmPasswordLabel,
                  errorText: cc.confirmPasswordError,
                  iconData: cc.confirmPasswordIconData,
                  isPassword: true,
                  keyboardType: cc.confirmPasswordInputType,
                  validatorPattern: cc.confirmPasswordValidatorPattern,
                ),
                Visibility(
                  visible: !cc.isConfirmedPassword.value,
                  child: const Text(
                    'Les mots de passe ne correspondent pas',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const CustomSpace(heightMultiplier: 4),
                CustomFABButton(
                  tag: cc.registerTag,
                  text: cc.registerLabel,
                  backgroundColor: CustomColors.blueButton,
                  onPressed: () {
                    cc.isPressedRegisterButton.value = true;
                    if (cc.isPressedRegisterButton.value &&
                        cc.checkPasswordConfirmation()) {
                      cc.isConfirmedPassword.value = true;
                      cc.register();
                    } else {
                      cc.isConfirmedPassword.value = false;
                    }
                  },
                ),
                const CustomSpace(heightMultiplier: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
