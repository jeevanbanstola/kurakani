import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = "Users";
const String CHAT_COLLECTION = "Users";
const String MESSAGES_COLLECTION = "Users";

class DatabaseService {
  final FirebaseFirestore database = FirebaseFirestore.instance;
  DatabaseService() {}
  Future<DocumentSnapshot> getUser(String _uId) async {
    return database.collection(USER_COLLECTION).doc(_uId).get();
  }

  Future<void> updateUserLastActiveTime(String _uId) async {
    try {
      await database
          .collection(USER_COLLECTION)
          .doc(_uId)
          .update({"last_active": DateTime.now().toUtc()});
    } catch (e) {
      print(e);
    }
  }

  Future<void> createUser(
      String _uid, String _name, String _email, String _imageUrl) async {
    try {
      await database.collection(USER_COLLECTION).doc(_uid).set(
        {
          "name": _name,
          "email": _email,
          "last_active": DateTime.now().isUtc,
          "image": _imageUrl,
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
