import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.onFieldSubmittedValue,
      required this.onValidator,
      required this.keyBoardType,
      required this.hint,
      required this.obscureText,
      this.enable = true,
      this.autoFocus = false});

  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.all(15),
          hintStyle:
              TextStyle(color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.textFieldDefaultBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
      errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.alertColor),
      borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      ))
      ),
    );
  }
}
