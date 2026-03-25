import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../navigation/bottom_nav.dart';
import '../core/constants/route_constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteConstants.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RouteConstants.home:
      case RouteConstants.dashboard:
      case RouteConstants.routes:
      case RouteConstants.profile:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
