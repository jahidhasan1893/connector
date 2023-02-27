import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:connector/Screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>SignInScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color:Colors.blue,
        child: Center(child: Text('Connector',style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),)),
      )
    );
  }
}
