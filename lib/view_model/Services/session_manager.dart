
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/routes/route_name.dart';

class SessionController{

  static final SessionController _sessionController = SessionController._internal();

  String? userId;
  factory SessionController(){
    return _sessionController;
  }
  SessionController._internal(){

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