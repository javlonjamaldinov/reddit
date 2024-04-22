import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reddit/app_color.dart';
import 'package:reddit/components/custom_button_navbar.dart';
import 'package:reddit/components/drawer.dart';
import 'package:reddit/components/wall_post.dart';
import 'package:reddit/helper/helper_methods.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:reddit/page/add_page.dart';
import 'package:reddit/page/chat_page.dart';
import 'package:reddit/page/settings_page.dart';

import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const HomePage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    updateExistingDocuments();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void updateExistingDocuments() {
    FirebaseFirestore.instance.collection("User Posts").get().then((snapshot) {
      for (var doc in snapshot.docs) {
        if (!doc.data().containsKey('commentCount')) {
          doc.reference.update({'commentCount': 0});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "The Wall",
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: MyDrawer(
          onProfileTap: () {
            Navigator.pop(context);
            if (widget.userData != null &&
                widget.userData!.containsKey("uid")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(receiverID: widget.userData!["uid"]),
                ),
              );
            }
          },
          onSignOut: signOut,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: 
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onTabChange: (index) {
          print('Selected index: $index');
        },
        pages: [
          HomePage(userData: widget.userData),
          const ChatPage(),
          const AddPage(),
          const SettingsPage(),
          if (widget.userData != null && widget.userData!["uid"] != null)
            ProfilePage(receiverID: widget.userData!["uid"]),
        ],
      ),
    );
  }
}
// StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("User Posts")
//                     .orderBy(
//                       "TimeStamp",
//                       descending: false,
//                     )
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         final post = snapshot.data!.docs[index];
//                         final commentCount = post['commentCount'] ?? 0;
//                         return WallPost(
//                           commentCount: commentCount,
//                           message: post['messages'], 
//                           user: post['UserEmail'],
//                           postId: post.id,
//                           likes: List<String>.from(
//                             post['Likes'] ?? [],
//                           ),
//                           time: formatDate(
//                             post['TimeStamp'],
//                           ),
//                         );
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('Error: ${snapshot.error}'),
//                     );
//                   }
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),