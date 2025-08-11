import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String? Function(String?)? validator;
  final int? maxLines;
  const InputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      maxLines: maxLines ?? 1,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
