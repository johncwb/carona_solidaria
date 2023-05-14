import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthServices() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen(
      (User? user) {
        usuario = (user == null) ? null : user;
        isLoading = false;
        notifyListeners();
      },
    );
  }
}
