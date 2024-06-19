import 'package:get/get.dart';

class CustomBottomAppBarController extends GetxController {
  String _currentRoute = '';

  String get currentRoute => _currentRoute;

  @override
  void onInit() {
    super.onInit();
    _updateCurrentRoute();
    ever(Rx<String?>(Get.currentRoute), (_) => _updateCurrentRoute());
  }

  void _updateCurrentRoute() {
    _currentRoute = Get.currentRoute;
    update();
  }
}
