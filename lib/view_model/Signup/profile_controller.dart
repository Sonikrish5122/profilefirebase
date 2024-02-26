import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profilefirebase/res/Component/input_text_field.dart';
import 'package:profilefirebase/res/color.dart';
import 'package:profilefirebase/view_model/Services/session_manager.dart';

import '../../utils/routes/route_name.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:profilefirebase/utils/utils.dart';

class ProfileController with ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.camera,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.image_outlined,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Gallery"),
                  )
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userId.toString());

    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      'profile': newUrl.toString(),
    }).then((value) {
      Utils.taostMessage("Profile Updated");
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      Utils.taostMessage(error.toString());
      setLoading(false);
    });
  }

  Future<void> showUserNameDialogAlert(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Updated User Name')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      onFieldSubmittedValue: (value) {},
                      onValidator: (value) {

                      },
                      keyBoardType: TextInputType.text,
                      hint: "Enter Name",
                      obscureText: false)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancle")),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'userName': nameController.text.toString()
                    }).then((value) {
                      nameController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text("OK")),
            ],
          );
        });
  }

  Future<void> showPhoneDialogAlert(BuildContext context, String phoneno) {
    phoneController.text = phoneno;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Updated Phone Number')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      onFieldSubmittedValue: (value) {},
                      onValidator: (value) {

                      },
                      keyBoardType: TextInputType.phone,
                      hint: "Enter Phone Number",
                      obscureText: false)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancle")),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'phone': phoneController.text.toString()
                    }).then((value) {
                      phoneController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text("OK")),
            ],
          );
        });
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
