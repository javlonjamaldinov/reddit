import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit/src/components/all_buttoms/custom_button_navbar/custom_button_navbar.dart';
import 'package:reddit/src/components/drawer/drawer.dart';
import 'package:reddit/src/data/data.dart';
import 'package:reddit/src/models/post_models.dart';
import 'package:reddit/src/presentation/add_view/add_page.dart';
import 'package:reddit/src/presentation/chat_view/chat_page.dart';
import 'package:reddit/src/presentation/settings_view/settings_page.dart';

import '../profile_view/profile_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const HomePage({
    super.key,
    required this.userData,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

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
      body: FutureBuilder(
        future: Data().getDocuments(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final userData = PostModels.fromMap(snapshot.data![index]);
              return Card(
                child: Column(
                  children: [
                    Text(userData.username),
                    Text(userData.bio),
                    Text(userData.timeStamp.toString()),
                    Text(userData.likes),
                    Image.network(userData.imageURL),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onTabChange: (index) {
          log('Selected index: $index');
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