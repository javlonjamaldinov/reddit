import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reddit/src/models/post_models.dart';

class Data {
  static final postCollection =
      FirebaseFirestore.instance.collection('user_posts');
  Future<List<Map<String, dynamic>>> getDocuments() async {
    final QuerySnapshot querySnapshot = await postCollection.get();
    return querySnapshot.docs
        .map((doc) => doc.data())
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  Future<void> addUser({
    required String username,
    required String bio,
    required String imageURL,
    required String likes,
  }) async {
    final addPostColection = PostModels(
      imageURL: imageURL,
      timeStamp: Timestamp.now(),
      likes: likes,
      username: username,
      bio: bio,
    );
    await postCollection.doc(postCollection.id).set(addPostColection.toMap());
  }

  Future<void> ubData({
    required String username,
    required String bio,
    required String imageURL,
    required String likes,
    required String id,
  }) async {
    final addPostColection = PostModels(
      imageURL: imageURL,
      timeStamp: Timestamp.now(),
      likes: likes,
      username: username,
      bio: bio,
    );
    await postCollection
        .doc(postCollection.id)
        .update(addPostColection.toMap());
  }
}
