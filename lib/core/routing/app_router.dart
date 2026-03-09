import 'package:flutter/material.dart';
import 'package:safi_delivery/core/routing/routes.dart';
import 'package:safi_delivery/features/home/ui/home_screen.dart';
import 'package:safi_delivery/features/login/ui/login_screen.dart';
import 'package:safi_delivery/features/onboarding/ui/onboarding_screen.dart';
import 'package:safi_delivery/features/register/ui/register_screen.dart';
import 'package:safi_delivery/features/splash/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
