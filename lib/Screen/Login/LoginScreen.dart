import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/Screen/SignUp/SignUpScreen.dart';
import 'package:profilefirebase/utils/routes/route_name.dart';
import 'package:profilefirebase/view_model/Signup/login_controller.dart';
import 'package:provider/provider.dart';

import '../../res/Component/button_round.dart';
import '../../res/Component/input_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _fromKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      InputTextField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        onFieldSubmittedValue: (value) {},
                        onValidator: (value) {
                          return value.isEmpty ? "Enter Password" : null;
                        },
                        keyBoardType: TextInputType.emailAddress,
                        hint: "Password",
                        obscureText: true,
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.forgotScreen);
                  },
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(height: 20), // Add SizedBox to create space

              ChangeNotifierProvider(
                create: (_) => LoginController(),
                child: Consumer<LoginController>(
                  builder: (context, provider, child) {
                    return ButtonRound(
                      title: "Login",
                      // loading: provider.loading,
                      onPress: () {
                        if(_fromKey.currentState!.validate()){
                          provider.login(context, emailController.text , passwordController.text);
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 14,
              ),
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, RouteName.SignUpScreen);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: Text.rich(
                    TextSpan(text: "Don't Have an Account? ", children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
