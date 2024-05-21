import 'package:get/get.dart';
import 'package:remindme/screens/register_screen/view/register_screen.dart';
import '../../screens/password_screen/view/password_screen.dart';
import 'app_routes.dart';

import '../../screens/tasks_screen/view/tasks_screen.dart';
import '../../screens/login_screen/view/login_screen.dart';

class AppScreens {
  AppScreens._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: RoutePaths.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RoutePaths.tasks,
      page: () => const TasksScreen(),
    ),
    GetPage(
      name: RoutePaths.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: RoutePaths.password,
      page: () => const PasswordScreen(),
    ),
  ];
}
