import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  MessageTextField({
    super.key,
    this.onSubmitted,
    this.onPressed,
    this.controller,
    this.onChanged,
  });
  Function(String value)? onSubmitted;
  Function(String)? onChanged;
  void Function()? onPressed;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: "Message",
        suffixIconColor: kPrimaryColor,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.send_rounded,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
      ),
    );
  }
}
