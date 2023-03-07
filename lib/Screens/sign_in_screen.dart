import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connector/Screens/sign_in_button.dart';
import 'package:connector/Screens/my_text_field.dart';
import 'package:connector/Screens/sign_up_screen.dart';


class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});


  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  void signUserIn() async{
    User? user=FirebaseAuth.instance.currentUser;
    //if(user!=null) return HomeS
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(),
        password: passwordController.text.trim());
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
                controller: emailController,
                hintText: 'Username or Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),


              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),


              Padding(
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
              ),

              const SizedBox(height: 25),


              SignInButton(
                onTap: signUserIn,
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
              ),
*/
              const SizedBox(height: 50),



              const SizedBox(height: 50),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    child:Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: (){
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>SignUpScreen(),
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
