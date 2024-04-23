import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:reddit/src/presentation/add_view/add_page.dart';
import 'package:reddit/src/presentation/chat_view/chat_page.dart';
import 'package:reddit/src/presentation/home_view/home_page.dart';
import 'package:reddit/src/presentation/profile_view/profile_page.dart';
import 'package:reddit/src/presentation/settings_view/settings_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  final List<Widget> pages;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(.2))
          ],
          borderRadius: BorderRadius.circular(40),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 8,
              activeColor: Colors.grey.shade800,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: const Duration(milliseconds: 800),
              tabBackgroundColor: Colors.grey.shade200,
              tabs: [
                GButton(
                  icon: Icons.home,
                  onPressed: () {
                    if (selectedIndex != 0) {
                      onTabChange(0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(userData: {})),
                      );
                    }
                  },
                ),
                GButton(
                  icon: Icons.chat,
                  onPressed: () {
                    if (selectedIndex != 1) {
                      onTabChange(1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatPage(),
                        ),
                      );
                    }
                  },
                ),
                GButton(
                  icon: Icons.add,
                  onPressed: () {
                    if (selectedIndex != 2) {
                      onTabChange(2);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPage(),
                        ),
                      );
                    }
                  },
                ),
                GButton(
                  icon: Icons.settings,
                  onPressed: () {
                    if (selectedIndex != 3) {
                      onTabChange(3);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    }
                  },
                ),
                GButton(
                  icon: Icons.person,
                  onPressed: () {
                    if (selectedIndex != 4) {
                      onTabChange(4);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProfilePage(receiverID: 'some_receiver_id'),
                        ),
                      );
                    }
                  },
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                onTabChange(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
