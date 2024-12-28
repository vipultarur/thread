import 'package:flutter/material.dart';
import 'package:thread/utils/type_def.dart';

class AuthInput extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final IconData icon;
  final TextEditingController controller;
  final ValidatorCallback validatorCallback; // Ensure this matches your typedef

  const AuthInput({
    Key? key,
    required this.labelText,
    this.isPassword = false,
    required this.icon,
    required this.controller,
    required this.validatorCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validatorCallback,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
