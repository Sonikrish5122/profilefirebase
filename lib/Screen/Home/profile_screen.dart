import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/view_model/Services/session_manager.dart';
import 'package:profilefirebase/view_model/Signup/profile_controller.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../../utils/routes/route_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child:
              Consumer<ProfileController>(builder: (context, provider, child) {
            return Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder(
                  stream:
                      ref.child(SessionController().userId.toString()).onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    // if (snapshot.hasData) {
                    //   return Center(child: CircularProgressIndicator());
                    // }
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.primaryTextTextColor,
                                          width: 2,
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: provider.image == null
                                          ? map['profile'].toString() == ""
                                              ? Icon(
                                                  Icons.camera_alt,
                                                  size: 70,
                                                )
                                              : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      map['profile']
                                                          .toString()),
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  },
                                                  errorBuilder:
                                                      (context, object, stack) {
                                                    return Container(
                                                      child: Icon(
                                                        Icons.error_outline,
                                                        color: Colors.red,
                                                      ),
                                                    );
                                                  })
                                          : Image.file(
                                              File(provider.image!.path)
                                                  .absolute),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  provider.pickImage(context);
                                },
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.primaryIconColor,
                                  child: Icon(
                                    CupertinoIcons.add_circled,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.showUserNameDialogAlert(
                                  context, map['userName']);
                            },
                            child: ReusbaleRow(
                              title: 'User Name',
                              value: map['userName'],
                              iconData: Icons.person,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.showPhoneDialogAlert(
                                  context, map['phone']);
                            },
                            child: ReusbaleRow(
                              title: 'Phone No',
                              value: map['phone'] == ''
                                  ? 'xxx-xxxx-xxx'
                                  : map['phone'],
                              iconData: Icons.phone,
                            ),
                          ),
                          ReusbaleRow(
                            title: 'Email Id',
                            value: map['email'],
                            iconData: Icons.email_outlined,
                          ),

                        ],
                      );
                    } else if (snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                          child: Text(
                        "Something went wrong",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ));
                    }
                  },

                )

            );
          }),
        ));
  }
}

class ReusbaleRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusbaleRow(
      {super.key,
      required this.title,
      required this.value,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: Text(value),
          leading: Icon(iconData),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.5),
        )
      ],
    );
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
}
