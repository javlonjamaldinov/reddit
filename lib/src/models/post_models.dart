// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModels {
  final String username;
  final String bio;
  final String imageURL;
  final Timestamp timeStamp;
  final String likes;

  PostModels(
      {required this.imageURL,
      required this.timeStamp,
      required this.likes,
      required this.username,
      required this.bio});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'bio': bio,
      'imageURL': imageURL,
      'timeStamp': timeStamp,
      'likes': likes,
    };
  }

  factory PostModels.fromMap(Map<String, dynamic> json) {
    return PostModels(
      username: json['username'] as String,
      bio: json['bio'] as String,
      imageURL: json['imageURL'] as String,
      likes: json['likes'] as String,
      timeStamp: json['timeStamp'] as Timestamp,
    );
  }
}
