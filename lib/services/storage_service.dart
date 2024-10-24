import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

const String USER_COLLECTION = "Users";

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> saveUserImage(String _uid, PlatformFile _file) async {
    try {
      Reference _ref =
          storage.ref().child('images/users/$_uid/profile.${_file.extension}');
      UploadTask uploadTask = _ref.putFile(File(_file.path!));    
      return await uploadTask.then((_result)=>
        _result.ref.getDownloadURL(),
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> saveChatImage(String _chatID, String _uid, PlatformFile _file ) async{
    try {
      Reference _ref = storage.ref().child('images/chats/$_chatID/${_uid}_${Timestamp.now().millisecondsSinceEpoch}.${_file.extension}');
            UploadTask uploadTask = _ref.putFile(File(_file.path!));    
      return await uploadTask.then((_result)=>
        _result.ref.getDownloadURL(),
      );
    } catch (e) {
      print(e);
      return null;
    }
  }
}
