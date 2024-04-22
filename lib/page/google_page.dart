import 'package:flutter/material.dart';

class GooglePage extends StatelessWidget {
  const GooglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Container(
              height: 55,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: Colors.grey.shade500),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      'assets/images/free-icon-google-720255.png',
                      height: 25,
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 50),
                  const Text(
                    'Continue whih Google',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 17),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            child: Container(
              height: 55,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: Colors.grey.shade500),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      'assets/images/facebook.png',
                      height: 25,
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 50),
                  const Text(
                    'Continue whih Facebook',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
