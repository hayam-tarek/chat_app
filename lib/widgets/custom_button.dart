import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kFirstColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
