import 'package:flutter/material.dart';
import 'package:reddit/components/custom_button_navbar.dart';
import 'package:reddit/page/chat_page.dart';
import 'package:reddit/page/home_page.dart';
import 'package:reddit/page/profile_page.dart';
import 'package:reddit/page/settings_page.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key, });

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
          print('Selected index: $index');
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
