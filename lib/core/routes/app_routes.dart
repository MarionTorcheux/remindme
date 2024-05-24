abstract class Routes {
  Routes._();

  static const login = RoutePaths.login;
  static const register = RoutePaths.register;
  static const password = RoutePaths.password;

  static const tasks = RoutePaths.tasks;
  static const lists = RoutePaths.lists;
  static const profile = RoutePaths.profile;
  static const history = RoutePaths.history;
  static const sharedlists = RoutePaths.sharedlists;
  static const listDetail = RoutePaths.listdetail;
}

abstract class RoutePaths {
  RoutePaths._();

  static const login = '/login';
  static const password = '/password';
  static const register = '/register';

  static const lists = '/lists';
  static const tasks = '/tasks';
  static const profile = '/profile';
  static const history = '/history';
  static const sharedlists = '/sharedlists';
  static const listdetail = '/listdetail';
}
