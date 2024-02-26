
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/Screen/Home/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../res/color.dart';
import '../../utils/routes/route_name.dart';
import '../../view_model/Services/session_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = PersistentTabController(initialIndex: 0);
  List<Widget>  _buildScreen(){
    return [
      Center(child: Text("Home")),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem(){
    return [
      PersistentBottomNavBarItem(icon: Icon(CupertinoIcons.home,color: Colors.white,)),
      PersistentBottomNavBarItem(icon: Icon(Icons.person,color: Colors.white))
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((value) {
                SessionController().userId = '';
                Navigator.pushNamed(context, RouteName.loginView);
              });
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: PersistentTabView(
          context,
          screens: _buildScreen(),
          items: _navBarItem(),
          controller: controller,
          backgroundColor: AppColors.secondaryTextColor,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          navBarStyle: NavBarStyle.style14,
        ),
      ),
    );
  }
}




