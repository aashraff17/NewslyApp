import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'providers/app_auth_provider.dart';
import 'providers/news_provider.dart';
import 'providers/bookmark_provider.dart';
import 'providers/chatbot_provider.dart';
import 'providers/language_provider.dart';
import 'routing/app_router.dart';
import 'core/theme/app_theme.dart'; // Import your new theme file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      // REMOVED the Consumer<AppAuthProvider> here
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        // Only one theme now
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF5FA8A3),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        ),
      ),
    );
  }
}