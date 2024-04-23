// import 'package:flutter/material.dart';
// import 'package:reddit/page/add_page.dart';
// import 'package:reddit/page/chat_page.dart';
// import 'package:reddit/page/home_page.dart';
// import 'package:reddit/page/profile_page.dart';

// class BottomNavigation extends StatefulWidget {
//   final Map<String, dynamic>? userData;

//   const BottomNavigation({
//     required this.userData,
//     super.key,
//   });
//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int _selectedIndex = 2;
//   final bool _isCartExpanded = false;

//   final List<Widget> _pages = [
//     const HomePage(userData: {}),
//     const ChatPage(),
//     const AddPage(),
//     ProfilePage(receiverID: widget.userData!["uid"])
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: SizedBox(
//         height: 85,
//         child: BottomNavigationBar(
//           fixedColor: const Color(0xffF72055),
//           currentIndex: _selectedIndex,
//           onTap: (value) {
//             setState(() {});
//             _selectedIndex = value;
//           },
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add),
//               label: 'Лента',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.favorite),
//               label: 'Избранное',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat),
//               label: 'dkkd',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Профиль',
//             ),
//             BottomNavigationBarItem(
//                 label: 'Корзина', icon: Icon(Icons.padding)),
//           ],
//         ),
//       ),
//     );
//   }
// }
