import 'package:intl/intl.dart';

String getDateHeader(DateTime messageDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDay =
        DateTime(messageDate.year, messageDate.month, messageDate.day);

    if (messageDay == today) {
      return 'Today';
    } else if (messageDay == yesterday) {
      return 'Yesterday';
    } else if (now.difference(messageDay).inDays < 7) {
      return DateFormat('EEEE')
          .format(messageDate); // Day name (e.g., "Monday")
    } else {
      return DateFormat('MMMM d, y').format(messageDate); // "January 1, 2024"
    }
  }

  String _formatMessageTime(DateTime timestamp) {
    return DateFormat('h:mm a').format(timestamp); // "2:30 PM"
  }