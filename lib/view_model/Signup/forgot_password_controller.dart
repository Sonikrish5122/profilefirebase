import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotpassword(BuildContext context, String email) async {
    setLoading(true);

    try {
      await auth.sendPasswordResetEmail(
        email: email,
      ).then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginView);
        Utils.taostMessage("Please Check your email to recover your password");
      }).onError((error, stackTrace) {
        Utils.taostMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.taostMessage(e.toString());
    }
  }
}
