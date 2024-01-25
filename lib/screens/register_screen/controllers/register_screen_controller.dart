import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/unique_controllers.dart';
import '../../../core/routes/app_routes.dart';

class RegisterScreenController extends GetxController {
  String pageTitle = 'Inscription'.toUpperCase();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String customBottomAppBarTag = 'register-bottom-app-bar';

  String nameTag = 'register-name';
  String nameLabel = 'Prénom';
  String nameError = 'Veuillez entrer un prénom';
  IconData nameIconData = Icons.person_outline;
  TextInputType nameInputType = TextInputType.name;
  String nameValidatorPattern = r'^[a-zA-Z]{2,}$';
  TextEditingController nameController = TextEditingController();


  String emailTag = 'register-email';
  String emailLabel = 'Email';
  String emailError = 'Veuillez entrer une adresse mail valide';
  IconData emailIconData = Icons.email_outlined;
  TextInputType emailInputType = TextInputType.emailAddress;
  String emailValidatorPattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
  TextEditingController emailController = TextEditingController();

  String passwordTag = 'register-password';
  String passwordLabel = 'Mot de Passe';
  String passwordError = 'Veuillez entrer un mot de passe';
  IconData passwordIconData = Icons.lock_open_outlined;
  TextInputType passwordInputType = TextInputType.visiblePassword;
  String passwordValidatorPattern = r'^.{8,}$';
  TextEditingController passwordController = TextEditingController();

  String confirmPasswordTag = 'register-confirm-password';
  String confirmPasswordLabel = 'Confirmer le mot de passe';
  String confirmPasswordError = 'Veuillez confirmer votre mot de passe';
  IconData confirmPasswordIconData = Icons.lock_open_outlined;
  TextInputType confirmPasswordInputType = TextInputType.visiblePassword;
  String confirmPasswordValidatorPattern = r'^.{8,}$';
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isConfirmedPassword = true.obs;
  RxBool isPressedRegisterButton = false.obs;

  void loginScreenOnPressed() {
    Get.toNamed(Routes.login);
  }

  String registerTag = 'register';
  String registerLabel = 'Inscription'.toUpperCase();
  IconData registerIconData = Icons.app_registration_outlined;

  bool checkPasswordConfirmation() {
    if (passwordController.text == confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      UniquesControllers().data.isInAsyncCall.value = true;

      UniquesControllers().getStorage.write('email', emailController.text);
      UniquesControllers().getStorage.write('password', passwordController.text);

      final user = await UniquesControllers().data.firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      await UniquesControllers().data.firebaseFirestore.collection('lister').doc(user.user!.uid).set(
        {
          'name': nameController.text,
          'email': emailController.text,
        },
      );


      UniquesControllers().data.isInAsyncCall.value = false;

      Get.toNamed(Routes.login);

      UniquesControllers().data.snackbar('Inscription réussie',
          '   ${nameController.text} !', false);
    } catch (e) {
      UniquesControllers().data.isInAsyncCall.value = false;
      UniquesControllers().data.snackbar('Erreur lors de la connexion', e.toString(), true);
    }
  }


}