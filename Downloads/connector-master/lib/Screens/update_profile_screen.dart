

import 'dart:io';

import 'package:connector/Widgets/save_button.dart';
import 'package:connector/Widgets/update_profile_button.dart';
import 'package:connector/Widgets/upload_profile_picture_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_screen.dart';
import 'my_text_field.dart';


class UpdateProfileScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  final passwordController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    saveUserDetails() {
      User? user = FirebaseAuth.instance.currentUser;
      if (usernameController.text.toString() != null) {
        user?.updateDisplayName(usernameController.text.toString());
      }
      if (emailController.text.toString() != null) {
        user?.updateEmail(emailController.text.toString());
      }
      if (passwordController.text.toString() != null) {
        user?.updatePassword(passwordController.text.toString());
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User profile updated")));
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen(),
                ),
              );
            },
          ),
          title: Text("Update Profile"),
          backgroundColor: Colors.blue,

        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextField(
                  controller: usernameController,
                  hintText: 'Update username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: 'Change email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter current password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController2,
                  hintText: 'Enter new password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController3,
                  hintText: 'Confirm new password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                UploadProfilePictureButton(onTap: uploadProfilePic),
                const SizedBox(height: 20),
                SaveButton(onTap: saveUserDetails),

              ],
            ),
          ),
        )
    );
  }


  uploadProfilePic() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile? image;
    User? user = FirebaseAuth.instance.currentUser;
    //Check Permissions
    var check=await Permission.photos.request();
    print(check);

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('images/imageName')
            .putFile(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        user?.updatePhotoURL(downloadUrl);
      }
    }
  }
}