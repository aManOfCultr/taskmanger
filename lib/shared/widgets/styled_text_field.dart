import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;

  const StyledTextField({
    Key? key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.keyboardType,
    this.isPassword = false,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.controller,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      obscureText: isPassword,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Enables floating behavior
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
    
  }
}
