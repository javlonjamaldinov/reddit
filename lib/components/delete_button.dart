import 'package:flutter/material.dart';
import 'package:reddit/app_color.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onTap;
  const DeleteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.more_vert,
        color: AppColors.grey,
      ),
    );
  }
}
