import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            '''
Newsly – Terms & Conditions

1. Introduction
Newsly is a news browsing application that provides users with access to news articles from multiple sources and categories.

2. User Accounts
Users may create an account using their email address. Users are responsible for maintaining the confidentiality of their login credentials.

3. Content
All news content displayed in the application is provided by third-party news APIs. Newsly does not own or modify the original content.

4. Usage
Users agree to use the application for personal, non-commercial purposes only.

5. Bookmarks
Saved articles are stored locally for user convenience and can be removed at any time.

6. Privacy
Newsly respects user privacy. No sensitive personal data is shared with third parties without user consent.

7. Changes
Newsly reserves the right to update these terms at any time.

8. Contact
For questions or support, please contact the Newsly team.

© 2025 Newsly
            ''',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
        ),
      ),
    );
  }
}
