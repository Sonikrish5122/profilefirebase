import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:profilefirebase/Screen/Home/home_screen.dart';
import 'package:profilefirebase/Screen/Login/LoginScreen.dart';
import 'package:profilefirebase/Screen/SignUp/SignUpScreen.dart';
import 'package:profilefirebase/res/color.dart';
import 'package:profilefirebase/utils/routes/route_name.dart';
import 'package:profilefirebase/view_model/Signup/forgot_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(name: "android");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCtJbGg0Kyaf-wTUQ7KDcqmeUWITfS_Y48',
          appId: '1:814574505639:android:a8a90f3fdb808727295582',
          messagingSenderId: '814574505639',
          projectId: 'profilefirebase-321a2',
          storageBucket: 'profilefirebase-321a2.appspot.com'));
  initializeFirebase();
  runApp(const MyApp());
}

void getFCMToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();

  print("FCM Token: $fcmToken ");
}

Future<void> initializeFirebase() async {
  Firebase.initializeApp().whenComplete(() {
    print("FirebaseinitializeApp-completed");
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    getFCMToken();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            color: AppColors.whiteColor,
            centerTitle: true,
            titleTextStyle:
                TextStyle(fontSize: 22, color: AppColors.primaryTextTextColor)),
        useMaterial3: true,
      ),
      initialRoute: RouteName.loginView,
      routes: {
        RouteName.loginView: (context) => LoginScreen(),
        RouteName.SignUpScreen: (context) => SignUpScreen(),
        RouteName.HomeScreen: (context) => HomeScreen(),
        RouteName.forgotScreen: (context) => ForgotPassword(),
      },
    );
  }
}
