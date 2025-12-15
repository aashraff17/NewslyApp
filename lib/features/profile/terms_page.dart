import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text(
          '''
Newsly Terms & Conditions

1. Content is provided for informational purposes only.
2. Newsly is not responsible for accuracy of third-party sources.
3. Users must not misuse the application.
4. Accounts violating rules may be terminated.
5. Data is handled according to privacy laws.

© 2025 Newsly
''',
        ),
      ),
    );
  }
}
