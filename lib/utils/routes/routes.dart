import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/Screen/Home/home_screen.dart';
import 'package:profilefirebase/Screen/SignUp/SignUpScreen.dart';
import 'package:profilefirebase/utils/routes/route_name.dart';
import 'package:profilefirebase/view_model/Signup/forgot_password.dart';

import '../../Screen/Login/LoginScreen.dart';
import '../../view_model/Services/session_manager.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case RouteName.loginView:

        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteName.SignUpScreen:

        return MaterialPageRoute(builder: (_) => const SignUpScreen());


      case RouteName.HomeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteName.forgotScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

void isLogin(BuildContext context) {
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if (user != null) {
    SessionController().userId = user.uid.toString();
    Navigator.pushReplacementNamed(context, RouteName.HomeScreen);
  } else {
    Navigator.pushNamed(context, RouteName.loginView);
  }
}