abstract class Routes{
  Routes._();

    static const login = RoutePaths.login;
    static const register = RoutePaths.register;
    static const password = RoutePaths.password;

    static const tasks = RoutePaths.tasks;

}

abstract class RoutePaths{
  RoutePaths._();

    static const login = '/login';
    static const password = '/password';
    static const register = '/register';

    static const tasks = '/tasks';

}