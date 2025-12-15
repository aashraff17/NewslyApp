import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> onboardingItems = [
    const OnboardingItem(
      icon: Icons.public,
      title: 'First to know',
      subtitle: 'All news in one place, be the first to know latest news',
    ),
    const OnboardingItem(
      icon: Icons.category,
      title: 'Browse by category',
      subtitle: 'Politics, sports, technology and more',
    ),
    const OnboardingItem(
      icon: Icons.bookmark,
      title: 'Save your favorites',
      subtitle: 'Bookmark articles and read them anytime',
    ),
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);

    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5FA8A3),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemCount: onboardingItems.length,
                  itemBuilder: (_, index) {
                    return onboardingItems[index];
                  },
                ),
              ),

              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingItems.length,
                      (index) => Container(
                    margin: const EdgeInsets.all(4),
                    width: _currentIndex == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.black
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Button
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == onboardingItems.length - 1) {
                        _finishOnboarding();
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentIndex == onboardingItems.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
