import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/view_model/Services/session_manager.dart';


import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String email, String password) async {
    setLoading(true);

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        SessionController().userId = value.user!.uid.toString();

        setLoading(false);
        Navigator.pushNamed(context, RouteName.HomeScreen);
      }).onError((error, stackTrace) {
        Utils.taostMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.taostMessage(e.toString());
    }
  }
}
