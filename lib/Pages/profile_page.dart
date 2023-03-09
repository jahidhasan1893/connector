import 'package:connector/Screens/sign_out_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Screens/splash_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
}
