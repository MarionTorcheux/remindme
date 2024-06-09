import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/unique_controllers.dart';
import '../../../core/routes/app_routes.dart';

class LoginScreenController extends GetxController {
  String imgTopPath = 'images/toplogin.svg';
  String pageTitle = 'Connexion';
  String emailTag = 'email';
  String emailLabel = 'Email';
  String emailError = 'Veuillez entrer une adresse mail valide';
  TextInputType emailInputType = TextInputType.emailAddress;
  TextEditingController emailController = TextEditingController();

  String passwordTag = 'password';
  String passwordLabel = 'Mot de Passe';
  String passwordError = 'Veuillez entrer un mot de passe';

  TextInputType passwordInputType = TextInputType.visiblePassword;
  TextEditingController passwordController = TextEditingController();

  String forgotPasswordTag = 'forgotPassword';
  String forgotPasswordLabel = 'Mot de passe oublié ?';
  double maxWith = 350.0;

  String connexionTag = 'connexion';
  String connexionLabel = 'Connexion';
  IconData connectionIconData = Icons.login_outlined;

  String textNoAccountYet = 'Pas encore de compte ?';
  String tagCreateNewAccount = 'createNewAccount';
  String textCustomButtonCreateNewAccount = 'Créer';

  String textApplicationVersion = 'Version 1.0.0';

  void passwordScreenOnPressed() {
    Get.toNamed(Routes.password);
  }

  void registerScreenOnPressed() {
    Get.toNamed(Routes.register);
  }

  void login() async {
    try {
      UniquesControllers().data.isInAsyncCall.value = true;

      UniquesControllers().getStorage.write('email', emailController.text);
      UniquesControllers()
          .getStorage
          .write('password', passwordController.text);

      final user = await UniquesControllers()
          .data
          .firebaseAuth
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      UniquesControllers().getStorage.write('currentUserUID', user.user!.uid);

      UniquesControllers().data.isInAsyncCall.value = false;
      Get.toNamed(Routes.lists);
    } catch (e) {
      UniquesControllers().data.isInAsyncCall.value = false;
      UniquesControllers().data.snackbar('Erreur lors de la connexion',
          'Email ou mot de passe invalide', true);
    }
  }

  @override
  void onReady() {
    super.onReady();
    emailController.text = UniquesControllers().getStorage.read('email') ?? '';
    passwordController.text =
        UniquesControllers().getStorage.read('password') ?? '';
  }
}
