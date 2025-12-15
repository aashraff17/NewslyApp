import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  // ==========================
  // 👤 PROFILE DATA
  // ==========================
  String get displayName => user?.displayName ?? 'Newsly User';
  String get email => user?.email ?? '';

  String _tempName = '';

  void updateName(String value) {
    _tempName = value;
  }

  Future<void> saveProfile() async {
    if (user == null) return;

    await user!.updateDisplayName(_tempName);
    await user!.reload();
    notifyListeners();
  }

  // ==========================
  // 🌙 DARK MODE
  // ==========================
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  // ==========================
  // 🔐 LOGIN
  // ==========================
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
  }

  // ==========================
  // 🔐 SIGN OUT
  // ==========================
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  // ==========================
  // ❌ DELETE ACCOUNT
  // ==========================
  Future<void> deleteAccount() async {
    await user?.delete();
    notifyListeners();
  }
}
