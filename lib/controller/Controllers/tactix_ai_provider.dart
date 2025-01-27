import 'dart:async';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class TactixAiProvider extends ChangeNotifier {
  static const int _maxMessageHistory = 100;
  static const Duration _timeout = Duration(seconds: 30);

  final Gemini tactixAi = Gemini.instance;
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final ChatUser currentUser = ChatUser(
    id: '0',
    firstName: 'User',
  );

  final ChatUser geminiUser = ChatUser(
    id: '1',
    firstName: 'TactixAI',
    profileImage:
        'https://res.cloudinary.com/dplpu9uc5/image/upload/v1736923321/tactix-bot_h6j5as.jpg',
  );

  Future<void> sendMessage(ChatMessage chatMessage) async {
    try {
      _errorMessage = null;
      _addMessage(chatMessage);
      _setLoading(true);

      var responseStream = tactixAi.streamGenerateContent(chatMessage.text);
      String fullResponse = '';

      await for (final event in responseStream.timeout(_timeout)) {
        final response = event.content?.parts
                ?.fold('', (prev, curr) => '$prev ${curr.text}')
                .trim() ??
            '';

        fullResponse += response;
        _updateLatestAiResponse(fullResponse);
      }
    } on TimeoutException {
      _handleError('Response timeout. Please try again.');
    } catch (error) {
      _handleError('An error occurred: ${error.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _addMessage(ChatMessage message) {
    // Convert message text to include TextSpans for formatting
    final formattedMessage = ChatMessage(
      user: message.user,
      createdAt: message.createdAt,
      text: message.text,
      customProperties: {
        'formatted': _processFormattedText(message.text),
      },
    );

    _messages = [formattedMessage, ..._messages];
    _trimMessageHistoryIfNeeded();
    notifyListeners();
  }

  void _updateLatestAiResponse(String response) {
    ChatMessage aiMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text: response,
      customProperties: {
        'formatted': _processFormattedText(response),
      },
    );

    // Ensure AI response is appended, not replacing
    _messages = [aiMessage, ..._messages];
    _trimMessageHistoryIfNeeded();
    notifyListeners();
  }

  // Process text to handle bold formatting
  List<TextSpan> _processFormattedText(String text) {
    List<TextSpan> spans = [];
    RegExp exp = RegExp(r'\*\*(.*?)\*\*');
    int lastMatch = 0;

    for (Match match in exp.allMatches(text)) {
      // Add text before the match
      if (match.start > lastMatch) {
        spans.add(TextSpan(
          text: text.substring(lastMatch, match.start),
          style: const TextStyle(color: defaultTextColor),
        ));
      }

      // Add the bold text
      spans.add(TextSpan(
        text: match.group(1), // Text between **
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: defaultTextColor,
        ),
      ));

      lastMatch = match.end;
    }

    // Add any remaining text
    if (lastMatch < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatch),
        style: const TextStyle(color: defaultTextColor),
      ));
    }

    return spans;
  }

  void _handleError(String errorMessage) {
    _errorMessage = errorMessage;
    _addMessage(
      ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: 'Sorry, $errorMessage Please try again.',
      ),
    );
  }

  void _trimMessageHistoryIfNeeded() {
    if (_messages.length > _maxMessageHistory) {
      _messages = _messages.sublist(0, _maxMessageHistory);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearMessages() {
    _messages = [];
    _errorMessage = null;
    notifyListeners();
  }

  String exportChatHistory() {
    return _messages.map((message) {
      final timestamp = message.createdAt.toIso8601String();
      final user = message.user.firstName;
      return '[$timestamp] $user: ${message.text}';
    }).join('\n');
  }
}
