import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF5FA8A3); // Your Brand Color
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    const Icon(Icons.description_rounded, size: 48, color: primaryColor),
                    const SizedBox(height: 16),
                    Text(
                      'Legal Agreement',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please read these terms and conditions carefully before using the Newsly application.',
                      style: TextStyle(color: Colors.grey[600], height: 1.5),
                    ),
                    const SizedBox(height: 32),

                    // Terms List
                    _buildTermItem('1', 'Informational Purposes', 'Content provided by Newsly is for informational purposes only.', primaryColor),
                    _buildTermItem('2', 'Third-Party Sources', 'Newsly is not responsible for the accuracy or reliability of news from third-party sources.', primaryColor),
                    _buildTermItem('3', 'App Usage', 'Users must not misuse the application or attempt to disrupt its services.', primaryColor),
                    _buildTermItem('4', 'Termination', 'Accounts violating our rules or engaging in fraudulent activity may be terminated without notice.', primaryColor),
                    _buildTermItem('5', 'Privacy & Data', 'All user data is handled strictly according to applicable privacy laws and our policy.', primaryColor),

                    const SizedBox(height: 40),

                    // Footer
                    Center(
                      child: Text(
                        '© 2025 Newsly App. All rights reserved.',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermItem(String number, String title, String body, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number Indicator
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: TextStyle(color: Colors.grey[700], height: 1.5, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}