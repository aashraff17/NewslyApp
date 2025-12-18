import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Ensure this is in pubspec.yaml

class AppAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  // PROFILE DATA
  String get displayName => user?.displayName ?? 'Newsly User';
  String get email => user?.email ?? '';
  String _tempName = '';

  void updateName(String value) => _tempName = value;

  Future<void> saveProfile() async {
    if (user == null) return;
    await user!.updateDisplayName(_tempName);
    await user!.reload();
    notifyListeners();
  }

  // 🗑️ DARK MODE REMOVED FROM HERE

  // AUTH METHODS
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    await user?.delete();
    notifyListeners();
  }
  // ... your existing code ...

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
  _isDarkMode = !_isDarkMode;
  notifyListeners(); // This tells the Consumer in main.dart to rebuild
  }
  }
