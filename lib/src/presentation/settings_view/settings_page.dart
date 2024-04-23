import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reddit/src/components/all_buttoms/custom_button_navbar/custom_button_navbar.dart';
import 'package:reddit/src/presentation/add_view/add_page.dart';
import 'package:reddit/src/presentation/chat_view/chat_page.dart';
import 'package:reddit/src/presentation/home_view/home_page.dart';
import 'package:reddit/src/presentation/profile_view/profile_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onTabChange: (index) {
          log('Selected index: $index');
        },
        pages: const [
          HomePage(userData: {}),
          ChatPage(),
          AddPage(),
          SettingsPage(),
          ProfilePage(receiverID: 'some_receiver_id'),
        ],
      ),
    );
  }
}
