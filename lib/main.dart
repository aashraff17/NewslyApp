import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/chatbot_provider.dart';

import 'routing/app_router.dart';
import 'providers/app_auth_provider.dart';
import 'providers/news_provider.dart';
import 'providers/bookmark_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCwogsrXe1sJDTCxQl-2oT1dtI0HHPoyl0",
      authDomain: "newsly-a351b.firebaseapp.com",
      projectId: "newsly-a351b",
      storageBucket: "newsly-a351b.firebasestorage.app",
      messagingSenderId: "440842846514",
      appId: "1:440842846514:web:479efcb72008c26bfb172b",
    ),
  );

  runApp(const NewslyApp());
}

class NewslyApp extends StatelessWidget {
  const NewslyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Newsly',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
