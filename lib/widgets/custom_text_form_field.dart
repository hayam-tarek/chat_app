import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.textInputType,
      this.obscureText,
      this.validator});

  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String? val)? validator;
  final TextInputType? textInputType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white24,
        filled: true,
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
