import 'package:flutter/material.dart';

class UploadProfilePictureButton extends StatelessWidget {
  final Function()? onTap;

  const UploadProfilePictureButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(
            color:Colors.black87,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Upload profile picture",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
