import 'package:flutter/material.dart';

class CustomInputFeild extends StatelessWidget {
  const CustomInputFeild({
    Key? key,
    this.hint,
    this.obscureText = false,
    required this.widget,
    this.labell,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String? hint;
  final bool obscureText;
  final Widget widget;
  final Widget? labell;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: labell,
        icon: Theme(
          data: ThemeData(primaryColor: Colors.black),
          child: widget,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 3),
        ),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
