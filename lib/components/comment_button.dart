import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  final VoidCallback onTap;
  final int commentCount;

  const CommentButton({
    super.key,
    required this.onTap,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Row(
        children: [
          Icon(Icons.comment),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
