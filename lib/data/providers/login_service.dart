import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginService extends ChangeNotifier {
  String _userId = '';
  String _errorMessage = '';

  String get getUserId => _userId;
  String get getErrorMessage => _errorMessage;

  void setErrorMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _userId = credential.user!.uid;

      return true;
    } on FirebaseAuthException catch (e) {
      setErrorMessage('Error during sign-in: ${e.message}');
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      setErrorMessage('Error during sign-up: ${e.message}');
      return false;
    }
  }

  Future<bool> signOut() {
    Completer<bool> signOutCompleter = Completer();

    FirebaseAuth.instance.signOut().then((value) {
      signOutCompleter.complete(true);
    }, onError: (error) {
      signOutCompleter.completeError({'error': error});
    });

    return signOutCompleter.future;
  }
}
