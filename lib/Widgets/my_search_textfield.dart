import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MySearchTextField({
  super.key,
  required this.controller,
  required this.hintText,
  required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              //borderRadius:BorderRadius.all(2.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
