import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AppAuthProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  User? get user => _auth.currentUser;


  bool get isAuthenticated => user != null;


  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }


  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }
}
