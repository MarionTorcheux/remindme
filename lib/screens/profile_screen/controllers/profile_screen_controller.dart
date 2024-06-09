import 'package:get/get.dart';

import '../../../core/classes/controller_mixin.dart';
import '../../../core/classes/unique_controllers.dart';

class ProfileScreenController extends GetxController with ControllerMixin {
  String titleProfileScreen = 'Mon profil';
  String tagBottomAppBarProfileScreen = 'bottomAppBarProfileScreen';
  String textButtonSignOut = 'Déconnexion';
  String tagButtonSignOut = 'buttonSignOut';
  String textCharge = 'Chargement...';

  void signOut() {
    UniquesControllers().getStorage.write('currentUserUID', null);
    Get.offAllNamed('/login');
  }
}
