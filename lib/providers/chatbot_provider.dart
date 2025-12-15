import 'package:flutter/material.dart';
import '../features/chatbot/models/chat_message.dart';

class ChatbotProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(
      ChatMessage(text: text, isUser: true),
    );
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Gemini API call here
      await Future.delayed(const Duration(seconds: 1));

      _messages.add(
        ChatMessage(
          text: "Sorry, something went wrong.",
          isUser: false,
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessage(
          text: "Error connecting to chatbot.",
          isUser: false,
        ),
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
