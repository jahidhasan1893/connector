import 'package:cached_network_image/cached_network_image.dart';
import 'package:connector/Screens/my_text_field.dart';
import 'package:connector/Screens/sign_out_button.dart';
import 'package:connector/Widgets/update_profile_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Screens/splash_screen.dart';
import '../Screens/update_profile_screen.dart';
import '../Widgets/save_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController1 = TextEditingController();
    final passwordController2 = TextEditingController();
    final passwordController3 = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.grey[300],
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              //const SizedBox(height: 60),
          CachedNetworkImage(
                imageUrl:'${user?.photoURL}'??'',
                placeholder: (conteext,url)=>CircularProgressIndicator(),
                errorWidget: (context,url,error)=>Icon(Icons.error,),
                imageBuilder: (context, imageProvider) => Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('${user?.displayName}',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              const SizedBox(height: 30),
              UpdateProfileButton(onTap: updateProfile),
              const SizedBox(height: 20),
              SignOutButton(onTap: signUserOut)
            ],
          ),
        ),
      )
    );
  }

  signUserOut() async{
    // Initialize Firebase Auth
    final FirebaseAuth _auth = FirebaseAuth.instance;

   // Sign out the user
    await _auth.signOut();
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>SplashScreen(),
      ),
    );
  }



  updateProfile() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>UpdateProfileScreen(),
      ),
    );
  }
}
