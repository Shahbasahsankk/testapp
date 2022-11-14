import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.keyboardType,
    required this.action,
    required this.controller,
    required this.validator,
    required this.obscure,
    required this.icon,
    required this.hint,
    required this.textCapitalization,
  });
  final TextInputType keyboardType;
  final TextInputAction action;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool obscure;
  final IconData icon;
  final String hint;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      autofocus: false,
      keyboardType: keyboardType,
      textInputAction: action,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscure,
    );
  }
}