import 'package:get/get.dart';
import 'package:remindme/screens/history_screen/view/history_screen.dart';
import 'package:remindme/screens/list_detail_screen/view/list_detail_screen.dart';
import 'package:remindme/screens/profile_screen/view/profile_screen.dart';
import 'package:remindme/screens/register_screen/view/register_screen.dart';
import 'package:remindme/screens/shared_lists_screen/view/shared_lists_screen.dart';
import '../../screens/lists_screen/view/lists_screen.dart';
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
    GetPage(
      name: RoutePaths.lists,
      page: () => const ListsScreen(),
    ),
    GetPage(
      name: RoutePaths.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: RoutePaths.sharedlists,
      page: () => const SharedListsScreen(),
    ),
    GetPage(
      name: RoutePaths.history,
      page: () => const HistoryScreen(),
    ),
    GetPage(
      name: RoutePaths.listdetail,
      page: () => const ListDetailScreen(),
    ),
  ];
}
