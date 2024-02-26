import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/view_model/Signup/forgot_password_controller.dart';
import 'package:provider/provider.dart';

import '../../res/Component/button_round.dart';
import '../../res/Component/input_text_field.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _fromKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Enter your Email address \nto recover your password",
                style: TextStyle(fontSize: 16,),
              ),

              SizedBox(height: 20),
              Form(
                  key: _fromKey,
                  child: Column(
                    children: [
                      InputTextField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        onFieldSubmittedValue: (value) {},
                        onValidator: (value) {
                          return value.isEmpty ? "Enter Email" : null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "Email",
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  )),

              SizedBox(height: 20), // Add SizedBox to create space

              ChangeNotifierProvider(
                create: (_) => ForgotPasswordController(),
                child: Consumer<ForgotPasswordController>(
                  builder: (context, provider, child) {
                    return ButtonRound(
                      title: "Reset",
                      loading: provider.loading,
                      onPress: () {
                        if(_fromKey.currentState!.validate()){
                          provider.forgotpassword(context, emailController.text);
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
