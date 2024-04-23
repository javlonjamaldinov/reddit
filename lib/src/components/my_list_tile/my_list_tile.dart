import 'package:flutter/material.dart';
import 'package:reddit/src/theme/app_color.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.backgroundColor,
        ),
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(color: AppColors.backgroundColor),
        ),
      ),
    );
  }
}
