import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCwogsrXe1sJDTCxQl-2oT1dtI0HHPoyl0",
    authDomain: "newsly-a351b.firebaseapp.com",
    projectId: "newsly-a351b",
    storageBucket: "newsly-a351b.firebasestorage.app",
    messagingSenderId: "440842846514",
    appId: "1:440842846514:web:479efcb72008c26bfb172b",
  );
}
