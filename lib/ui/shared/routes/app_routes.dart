import 'package:amir/ui/views/Authentication/Forgot_password/forgotpass.dart';
import 'package:amir/ui/views/Authentication/Sign_in/sign_in.dart';
import 'package:amir/ui/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case '/reset_password':
        return MaterialPageRoute(builder: (_) => ForgotPassScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
