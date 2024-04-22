import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  static final universityCollection =
      FirebaseFirestore.instance.collection('user_posts');
  Future<List<Map<String, dynamic>>> getDocuments() async {
    final QuerySnapshot querySnapshot = await universityCollection.get();
    return querySnapshot.docs
        .map((doc) => doc.data())
        .whereType<Map<String, dynamic>>()
        .toList();
  }
}
