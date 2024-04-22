import 'package:flutter/material.dart';
import 'package:reddit/components/custom_button_navbar.dart';
import 'package:reddit/page/add_page.dart';
import 'package:reddit/page/chat_page.dart';
import 'package:reddit/page/home_page.dart';
import 'package:reddit/page/profile_page.dart';

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
          print('Selected index: $index');
        },
        pages: [
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
