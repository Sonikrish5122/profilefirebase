
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:profilefirebase/utils/routes/route_name.dart';
import 'package:profilefirebase/utils/utils.dart';

import '../Services/session_manager.dart';

class SignUpController with ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('User');

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  void signup(BuildContext context, String username,String email,String password) async{
    setLoading(true);

    try{
     await auth.createUserWithEmailAndPassword(
        email : email,
        password : password,
      ).then((value){

       SessionController().userId = value.user!.uid.toString();
       dbRef.child(value.user!.uid.toString()).set({
         'uid' : value.user!.uid.toString(),
          'email' : value.user!.email.toString(),
          'phone' : '',
          'userName' : username,
          'profile' : '',

        }).then((value){
          setLoading(false);
          Navigator.pushNamed(context, RouteName.HomeScreen);
        }).onError((error, stackTrace){
          Utils.taostMessage(error.toString());
          setLoading(false);
        });
        Utils.taostMessage('User Created Successfully');

      }).onError((error, stackTrace){
        Utils.taostMessage(error.toString());
      });
      }catch(e){
      setLoading(false);
      Utils.taostMessage(e.toString());
    }
  }
}