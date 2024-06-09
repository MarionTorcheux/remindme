import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/unique_controllers.dart';
import '../../../core/routes/app_routes.dart';

class PasswordScreenController extends GetxController {
  String pageTitle = 'Mot de passe oublié';
  String svgImagePath = 'images/forgotpass.svg';

  String customBottomAppBarTag = 'password-bottom-app-bar';

  TextEditingController emailController = TextEditingController();

  String emailTag = 'password-email';
  String emailLabel = 'Email';
  String emailError = 'Veuillez entrer une adresse mail valide';
  IconData emailIconData = Icons.email_outlined;
  TextInputType emailInputType = TextInputType.emailAddress;

  String resetPasswordTag = 'password-reset-password';
  String resetPasswordLabel = 'Réinitialiser';
  IconData resetPasswordIconData = Icons.lock_reset_outlined;

  void loginScreenOnPressed() {
    Get.toNamed(Routes.login);
  }

  void resetPassword() async {
    try {
      UniquesControllers().data.isInAsyncCall.value = true;

      await UniquesControllers()
          .data
          .firebaseAuth
          .sendPasswordResetEmail(email: emailController.text);

      UniquesControllers().data.isInAsyncCall.value = false;
      Get.toNamed(Routes.login);
      UniquesControllers().data.snackbar(
          'Demande de réinitialisation de mot de passe',
          'Un email de réinitialisation de mot de passe vous a été envoyé',
          false);
    } catch (e) {
      UniquesControllers().data.isInAsyncCall.value = false;
      UniquesControllers().data.snackbar(
          'Erreur lors de la réinitialisation de mot de passe',
          'L\'adresse mail entrée n\'existe pas ou n\'est pas associée à un compte',
          true);
    }
  }

  @override
  void onReady() {
    super.onReady();
    emailController.text = UniquesControllers().getStorage.read('email') ?? '';
  }
}
