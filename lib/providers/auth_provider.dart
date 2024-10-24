import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurakani/models/chat_user.dart';
import 'package:kurakani/services/database_service.dart';
import 'package:kurakani/services/navigation_service.dart';

class AuthProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;
  late ChatUser _user;

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _databaseService.updateUserLastActiveTime(user.uid);
        _databaseService.getUser(user.uid).then((snapShot) {
          Map<String, dynamic> _userDetails =
              snapShot.data() as Map<String, dynamic>;
          print(_userDetails);
          _user = ChatUser.fromJSON({
            'uId': user.uid,
            "name": _userDetails['name'],
            "image": _userDetails['image'],
            "last_active": _userDetails['last_active'],
            "email": _userDetails['email'],
          });
          _navigationService.removeAndNavigateToRoute('/home');
        });
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
        print("Unauthenticated");
      }
    });
  }
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(_auth.currentUser);
    } on FirebaseAuthException {
      print("Error Logging User in Firebase");
    }
  }
Future<String?> registerUserUsingEmailAndPassword(String? email, String? password) async {
  try {
    UserCredential _userCredentials = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
    return _userCredentials.user?.uid;
  } on FirebaseAuthException catch (e) {
    // This captures the FirebaseAuthException with details
    print("Error registering user in Firebase: ${e.message}");
    return null;
  } catch (e) {
    // Catches any other exceptions
    print("An unexpected error occurred: $e");
    return null;
  }
}

      Future logout()async{
      try {
        await _auth.signOut();
      }
      catch (e){
        print(e);
      }
    }
}
