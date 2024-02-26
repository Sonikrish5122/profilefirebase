import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class ButtonRound extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;

  const ButtonRound(
      {Key? key,
      required this.title,
      required this.onPress,
      this.color = AppColors.primaryColor,
      this.textColor = AppColors.whiteColor,  this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: loading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 16,color: textColor),
            )),
      ),
    );
  }
}
