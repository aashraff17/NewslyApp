import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../features/chatbot/models/chat_message.dart';

class ChatbotProvider extends ChangeNotifier {
  final List<ChatMessage> messages = [];
  bool isLoading = false;

  final String _apiKey = 'AIzaSyDfLyIVcLZkcH9G2F3FY1w4LFCzQLkVdqo';

  Future<void> sendMessage(String userMessage) async {
    messages.add(ChatMessage(text: userMessage, isUser: true));
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_apiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userMessage}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botText =
        data['candidates'][0]['content']['parts'][0]['text'];

        messages.add(ChatMessage(text: botText, isUser: false));
      } else {
        messages.add(ChatMessage(
          text: 'Sorry, something went wrong.',
          isUser: false,
        ));
      }
    } catch (_) {
      messages.add(ChatMessage(
        text: 'Sorry, something went wrong.',
        isUser: false,
      ));
    }

    isLoading = false;
    notifyListeners();
  }
}
