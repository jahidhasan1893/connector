import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connector/Screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connector/Screens/sign_in_button.dart';
import 'package:connector/Screens/my_text_field.dart';
import 'package:connector/Screens/sign_in_screen.dart' as globe;
import 'package:connector/Screens/sign_up_button.dart';


import 'home_screen.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();

  final emailController=TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController=TextEditingController();

  Future<void> signUserUp() async {
    UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(),
        password: passwordController.text.trim());

    User? user =FirebaseAuth.instance.currentUser;
    user?.updateDisplayName(usernameController.text.trim());
    user?.updatePhotoURL('https://firebasestorage.googleapis.com/v0/b/connector-71f47.appspot.com/o/contact-dummy_landscape_964x656.jpg?alt=media&token=0559da6a-1aea-4858-a8a1-281f4b286da6');
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set(
      {
        'email':emailController.text,
        'username':usernameController.text,
        'photourl':'https://firebasestorage.googleapis.com/v0/b/connector-71f47.appspot.com/o/contact-dummy_landscape_964x656.jpg?alt=media&token=0559da6a-1aea-4858-a8a1-281f4b286da6',
      }).then((value) => print("User data saved"))
          .catchError((error) => print("Failed to save user data: $error"));

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async{
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Connector',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 25,
                ),
              ),

              const SizedBox(height: 70),

              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),


              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),


              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),


              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),*/

              const SizedBox(height: 25),


              SignUpButton(
                onTap: signUserUp,
              ),

              const SizedBox(height: 30),


              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),*/

              const SizedBox(height: 50),



              //const SizedBox(height: 50),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Registered?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    child:Text(
                      'Sign In now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: (){
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>SignInScreen(),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
