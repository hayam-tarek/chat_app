import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

void showSnakeBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kFirstColor,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    ),
  );
}
