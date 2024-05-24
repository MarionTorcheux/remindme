import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/classes/controller_mixin.dart';
import '../../../core/classes/unique_controllers.dart';

class ProfileScreenController extends GetxController with ControllerMixin {
  // deconnexion et retour à l'écran login
  void signOut() {
    UniquesControllers().getStorage.write('currentUserUID', null);
    Get.offAllNamed('/login');
  }
}
