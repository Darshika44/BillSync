import 'package:bill_sync_app/screens/home_tab/bottom_bar_screen.dart';
import 'package:bill_sync_app/screens/auth/login_screen.dart';
import 'package:bill_sync_app/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    // final args = routeSettings.arguments as dynamic;
    switch (routeSettings.name) {
      // ============onBoarding screens========>
      case '/':
        return MaterialPageRoute(builder: (ctx) => const SplashScreen());
      case '/login_screen':
        return MaterialPageRoute(builder: (ctx) => const LoginScreen());
      // case '/forget_password_screen':
      //   return MaterialPageRoute(builder: (ctx) => ForgetPasswordScreen());
      // case '/otp_screen':
      //   return MaterialPageRoute(builder: (ctx) => OtpScreen());
      // case '/change_password_screen':
      //   return MaterialPageRoute(builder: (ctx) => ChangePasswordScreen());
      case '/home_screen':
        return MaterialPageRoute(builder: (ctx) => const BottomBarScreen());
        // return MaterialPageRoute(builder: (ctx) => const HomeScreen());
      default:
        return null;
    }
  }
}
