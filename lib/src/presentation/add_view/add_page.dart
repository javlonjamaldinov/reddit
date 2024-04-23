import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reddit/src/components/all_buttoms/custom_button_navbar/custom_button_navbar.dart';
import 'package:reddit/src/presentation/chat_view/chat_page.dart';
import 'package:reddit/src/presentation/home_view/home_page.dart';
import 'package:reddit/src/presentation/settings_view/settings_page.dart';

class AddPage extends StatelessWidget {
  const AddPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2, // Set the index of the AddPage to 2
        onTabChange: (index) {
          // Handle tab change
          // You can implement your logic here to navigate to different pages
          // based on the index
          log('Selected index: $index');
        },
        pages: const [
          HomePage(userData: {}),
          ChatPage(),
          AddPage(),
          SettingsPage(),
          // ProfilePage(receiverID: 'some_receiver_id'),
        ],
      ),
    );
  }
}
