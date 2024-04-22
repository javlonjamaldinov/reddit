import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/app_color.dart';
import 'package:reddit/components/text_box.dart';
import 'package:reddit/components/write_text_field.dart';
import 'package:reddit/data/data.dart';
import 'package:reddit/models/mesagge.dart';

import 'package:reddit/page/home_page.dart';
import 'package:reddit/service/chat_service.dart';

class ProfilePage extends StatefulWidget {
  final String receiverID;
  final void Function(int)? updateNewMessagesCount;

  const ProfilePage({
    super.key,
    required this.receiverID,
    this.updateNewMessagesCount,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final textController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _myFocusNode = FocusNode();
  final ImageService _chatService = ImageService();
  int newMessagesCount = 0;
  final ScrollController _scrollController = ScrollController();

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: AppColors.backgroundColor),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: AppColors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.backgroundColor,
              ),
            ),
          ),
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: AppColors.backgroundColor,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  void postMessage() async {
    if (textController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("User Posts").add(
        {
          'UserEmail': currentUser.email,
          'Message': textController.text,
          'TimeStamp': Timestamp.now(),
          'Likes': [],
        },
      ).then((docRef) {
        docRef.update({'commentCount': 0});
        // Опубликовать пост на главной странице
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(userData: {}),
        ));
      });
    }
    setState(() {
      textController.clear();
    });
  }

  Future<void> _openImagePicker() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);
      // Создать новый пост с изображением
      await FirebaseFirestore.instance.collection("User Posts").add(
        {
          'UserEmail': currentUser.email,
          'ImageURL': pickedImage.path,
          'TimeStamp': Timestamp.now(),
          'Likes': [],
        },
      ).then((docRef) {
        docRef.update({'commentCount': 0});
        // Перейти на главную страницу и опубликовать новый пост
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(userData: {}),
        ));
      });
    }
  }

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverID,
        _messageController.text,
      );
      _messageController.clear();

      if (widget.updateNewMessagesCount != null) {
        widget.updateNewMessagesCount!(newMessagesCount + 1);
      }
      // Опубликовать сообщение на главной странице
      setState(() {}); // Вызываем setState для обновления страницы
    }
    scrollDown();
  }

  Widget buildMessageContainer(Map<String, dynamic>? data, bool isCurrentUser) {
    if (data != null) {
      Alignment alignment =
          isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

      return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data["isImage"] != null && data["isImage"] == true)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 280,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.network(
                    data["message"],
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
          future: Data().getDocuments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final userData = Message.fromMap(snapshot.data![index]);
                  return Card(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const Icon(
                          Icons.person,
                          size: 72,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentUser.email!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            'My Details',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        MyTextBox(
                          text: userData.,
                          sectionName: 'username',
                          onPressed: () => editField('username'),
                        ),
                        MyTextBox(
                          text: userData['bio'],
                          sectionName: 'bio',
                          onPressed: () => editField('bio'),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            'My Posts',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 310,
                                  child: WriteTextField(
                                    controller: _messageController,
                                    hintText: "Type a message..",
                                    obscureText: false,
                                    focusNode: _myFocusNode,
                                    icon: Icons.image,
                                    onIconPressed: _openImagePicker,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                margin: const EdgeInsets.only(right: 25),
                                child: IconButton(
                                  onPressed: sendMessage,
                                  icon: const Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
//