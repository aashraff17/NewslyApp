import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language')),
      body: Consumer<LanguageProvider>(
        builder: (context, lang, _) {
          return Column(
            children: [
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: lang.currentLanguage,
                onChanged: (value) {
                  if (value != null) {
                    lang.changeLanguage(value);
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Arabic'),
                value: 'ar',
                groupValue: lang.currentLanguage,
                onChanged: (value) {
                  if (value != null) {
                    lang.changeLanguage(value);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
