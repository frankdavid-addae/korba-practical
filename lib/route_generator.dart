// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:korba_practical/screens/auth/sign_in_screen.dart';
import 'package:korba_practical/screens/auth/sign_up_screen.dart';
import 'package:korba_practical/screens/home/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static goBack() {
    return navigatorKey.currentState!.pop();
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case SignUpScreen.routeName:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SignUpScreen(),
          duration: Duration(milliseconds: 100),
          reverseDuration: Duration(milliseconds: 100),
        );

      case SignInScreen.routeName:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SignInScreen(),
          duration: Duration(milliseconds: 100),
          reverseDuration: Duration(milliseconds: 100),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('Page Not Found!'),
        ),
      );
    });
  }
}
