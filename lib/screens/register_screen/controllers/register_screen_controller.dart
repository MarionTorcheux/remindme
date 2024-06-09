import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remindme/core/classes/controller_mixin.dart';

import '../../../core/classes/custom_colors.dart';
import '../../../core/classes/unique_controllers.dart';
import '../../../core/routes/app_routes.dart';

class RegisterScreenController extends GetxController with ControllerMixin {
  String pageTitle = 'Créer un compte';
  String tagIconButton = 'register-icon-button';
  String textProfilePicture = 'Photo de profil';
  TextStyle textStyleLabelRegister = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: CustomColors.mainWhite,
      fontFamily: 'Poppins');
  String textErrorPasswordCorrespondence =
      'Les mots de passe ne correspondent pas';
  TextStyle textStyleError = TextStyle(
      color: CustomColors.interaction, fontSize: 12, fontFamily: 'Poppins');

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
  String emailValidatorPattern =
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
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

  RxString selectedImagePath = ''.obs;

  void loginScreenOnPressed() {
    Get.toNamed(Routes.login);
  }

  String registerTag = 'register';
  String registerLabel = 'Inscription';
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
      UniquesControllers()
          .getStorage
          .write('password', passwordController.text);

      final user = await UniquesControllers()
          .data
          .firebaseAuth
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      String defaultAvatar =
          "https://firebasestorage.googleapis.com/v0/b/remindme-dc6a8.appspot.com/o/avatars%2FuserDefault.png?alt=media&token=da8ea2dc-7069-43f6-b4e4-94496912d4cf";

      String imageUrl = '';

      if (file.path != '') {
        imageUrl = await uploadImage(file, user.user!.uid);
      } else {
        imageUrl = defaultAvatar;
      }

      await UniquesControllers()
          .data
          .firebaseFirestore
          .collection('user')
          .doc(user.user!.uid)
          .set(
        {
          'avatarUrl': imageUrl,
          'name': nameController.text,
          'email': emailController.text,
        },
      );

      UniquesControllers().data.isInAsyncCall.value = false;

      Get.toNamed(Routes.login);

      UniquesControllers().data.snackbar(
          'Inscription réussie', 'Bienvenue ${nameController.text} !', false);
    } catch (e) {
      UniquesControllers().data.isInAsyncCall.value = false;
      UniquesControllers()
          .data
          .snackbar('Erreur lors de la connexion', e.toString(), true);
    }
  }

  Future<String> uploadImage(File file, String userId) async {
    final List<Future<String>> uploadTasks = [];
    String url = '';
    List<String> imageListLocalPath = <String>[];
    try {
      imageListLocalPath.add(file.path);

      final fileName = path.basename(file.path);
      final destination = '$destinationStorage/$userId/$fileName';

      final uploadTask = firebaseStorage.ref(destination).putFile(file);
      uploadTasks.add(uploadTask.then((taskSnapshot) async {
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();

        url = downloadUrl;
        return downloadUrl;
      }));

      await Future.wait(uploadTasks);
    } catch (e) {
      UniquesControllers()
          .data
          .snackbar('Erreur lors de l\'upload de l\'image', e.toString(), true);
    }
    return url;
  }

  //TODO SELECTION DE LA PHOTO DE PROFILE
  String deleteImageTag = 'delete-image';
  String destinationStorage = 'avatars';
  final firebaseStorage = FirebaseStorage.instance;
  RxBool isPickedFile = false.obs;
  File file = File('');

  void pickFiles() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        // Récupérer le chemin de l'image sélectionnée depuis le fichier
        String imagePath = result.files.single.path ?? '';

        // Mettre à jour selectedImagePath avec le chemin de l'image
        selectedImagePath.value = imagePath;
      } else {
        // L'utilisateur a annulé la sélection de fichier
        // Gérer le cas d'annulation si nécessaire
      }

      if (result != null) {
        if (result.files.single.path != null) {
          file = File(result.files.single.path!);
          isPickedFile.value = false;

          isPickedFile.value = true;
        }
      }
    } catch (e) {
      // Gérer les erreurs éventuelles lors de la sélection de fichier
      print('Erreur lors de la sélection de fichier : $e');
    }
  }
}
