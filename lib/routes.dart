import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do/auth/login.dart';
import 'package:to_do/auth/signup.dart';
import 'package:to_do/dashboard/calendar.dart';

class Application {
  static FluroRouter router;
}

class AppRoutes {
  static String home = '/';
  static String login = '/login';
  static String signup = '/signup';

  static void defineRoutes(FluroRouter router) {
    router.notFoundHandler = notFound;
    router.define(home, handler: homeHandler);

    router.define(login, handler: loginHandler);
    router.define(signup, handler: signupHandler);
  }
}

final notFound = Handler(handlerFunc: (_, __) => Container());
final homeHandler = Handler(handlerFunc: (_, __) => Calendar());

final loginHandler = Handler(handlerFunc: (_, __) => LoginController());
final signupHandler = Handler(handlerFunc: (_, __) => SignUpController());
