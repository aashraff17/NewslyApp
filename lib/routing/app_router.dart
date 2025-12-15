import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/layout/main_layout.dart';
import '../features/splash/splash_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/profile/language_page.dart';
import '../features/profile/change_password_page.dart';
import '../features/profile/terms_page.dart';
import '../features/profile/edit_profile_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => const MainLayout(),
      ),

      // ✅ PROFILE ROUTES (YOU WERE MISSING THESE)
      GoRoute(
        path: '/language',
        builder: (_, __) => const LanguagePage(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (_, __) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/terms',
        builder: (_, __) => const TermsPage(),
      ),
       GoRoute(
        path: '/edit-profile',
        builder: (_, __) => const EditProfilePage(),
      ),
    ],
  );
}
