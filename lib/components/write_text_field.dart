import 'package:flutter/material.dart';

class WriteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final VoidCallback? onIconPressed;
  final IconData? icon;

  const WriteTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.focusNode,
    this.onIconPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
        prefixIcon: icon != null
            ? GestureDetector(
                onTap: onIconPressed,
                child: Icon(icon),
              )
            : null,
      ),
    );
  }
}
