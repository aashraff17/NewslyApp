import 'package:flutter/material.dart';
import '../features/chatbot/models/chat_message.dart';

import 'package:flutter/material.dart';

class ChatbotProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  void sendMessage(String text) async {
    // 1. Add User Message
    _messages.add(ChatMessage(text: text, isUser: true));
    _isLoading = true;
    notifyListeners();

    // 2. Simulate Network Delay for the "Doctor" to see it "Thinking"
    await Future.delayed(const Duration(milliseconds: 1500));

    // 3. Generate a Smart Response
    String response = _generateSmartResponse(text);

    // 4. Add Bot Message
    _messages.add(ChatMessage(text: response, isUser: false));
    _isLoading = false;
    notifyListeners();
  }

  String _generateSmartResponse(String input) {
    final query = input.toLowerCase();

    if (query.contains('hello') || query.contains('hi')) {
      return "Hello! 👋 I'm your Newsly Assistant. I can tell you about the latest in Sports, Tech, Business, and more. What are you interested in today?";
    }

    if (query.contains('sports') || query.contains('football') || query.contains('win')) {
      return "There's a lot happening in sports! 🏆 The big news is the Underdogs' historic Champions League victory. Also, athletes are arriving at the new high-tech Olympic Village. Should I tell you more about the tournament?";
    }

    if (query.contains('tech') || query.contains('ai') || query.contains('smartphone')) {
      return "Technology is moving fast! 💻 We just saw a massive breakthrough in Quantum Computing with a 1000-qubit processor. Also, Generative AI is now revolutionizing cinematic production. Are you interested in Space Tech too?";
    }

    if (query.contains('business') || query.contains('money') || query.contains('stock')) {
      return "In Business news 💼, a major tech giant just acquired a semiconductor startup for \$40 Billion! Also, renewable energy stocks have reached an all-time high. It's a great time for green investments.";
    }

    if (query.contains('health') || query.contains('doctor') || query.contains('cancer')) {
      return "Health science is making huge leaps! 🩺 AI-driven personalized cancer treatments are showing incredible results in clinical trials. Also, researchers have found new links between gut health and daily energy levels.";
    }

    if (query.contains('science') || query.contains('discovery') || query.contains('ancient')) {
      return "Science is full of discoveries! 🔬 LiDAR mapping just revealed a hidden Mayan megacity in Guatemala, and Nuclear Fusion research is hitting net energy gain milestones. Want to hear about deep-sea exploration?";
    }

    if (query.contains('help') || query.contains('can you')) {
      return "I can help you navigate the daily headlines! Just ask me about 'World News', 'Entertainment', or specific topics like 'Climate' or 'Movies'.";
    }

    // Default "Smart" fallback
    return "That's an interesting question! While I'm still scanning the latest global wires for a specific answer, I can tell you that today's top trends involve AI Innovation and Global Economic shifts. Would you like to see the 'Nation' or 'World' category?";
  }
}