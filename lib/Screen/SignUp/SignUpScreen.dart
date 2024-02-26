import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/utils/routes/route_name.dart';
import 'package:profilefirebase/utils/utils.dart';
import 'package:profilefirebase/view_model/Signup/signup_controller.dart';
import 'package:provider/provider.dart';

import '../../res/Component/button_round.dart';
import '../../res/Component/input_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fromKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();

  final usernameController = TextEditingController();
  final usernameFocusNode = FocusNode();

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
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ChangeNotifierProvider(
            create: (_) => SignUpController(),
            child: Consumer<SignUpController>(
              builder: (context, provider ,child){
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Create A New Account ",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 20),
                      Form(
                          key: _fromKey,
                          child: Column(
                            children: [

                              InputTextField(
                                controller: usernameController,
                                focusNode: usernameFocusNode,
                                onFieldSubmittedValue: (value) {},
                                onValidator: (value) {
                                  return value.isEmpty ? "Enter Username" : null;
                                },
                                keyBoardType: TextInputType.emailAddress,
                                hint: "Username",
                                obscureText: false,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InputTextField(
                                controller: emailController,
                                focusNode: emailFocusNode,
                                onFieldSubmittedValue: (value) {
                                  Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                                },
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

                      SizedBox(height: 20), // Add SizedBox to create space
                      ButtonRound(
                        title: "Sign Up",
                        // loading: provider.loading,
                        onPress: () {
                          if(_fromKey.currentState!.validate()){
                            provider.signup(context, usernameController.text , emailController.text , passwordController.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RouteName.loginView);
                        },
                        child: Text.rich(TextSpan(text: "Already Have An Account ?  ", children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )
                        ])),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
