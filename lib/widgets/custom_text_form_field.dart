import 'package:flutter/material.dart';

class CustomTextformField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const CustomTextformField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (val) {
        return "Please fill the $labelText";
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: Text(labelText, style: TextStyle(color: Colors.grey.shade500)),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade500),
        ),
      ),
    );
  }
}
