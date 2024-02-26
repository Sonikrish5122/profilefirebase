
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../view_model/Services/session_manager.dart';

class RouteName {

  static const String loginView = 'login_view';
  static const String SignUpScreen = 'SignUpScreen';

  static const String HomeScreen = 'HomeScreen';

  static const String forgotScreen = 'forgotScreen';

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