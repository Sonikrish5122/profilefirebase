import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:profilefirebase/res/color.dart';

class Utils {
  static void fieldFocus(
      BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static taostMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.primaryTextTextColor,
        fontSize: 16);
  }
}
