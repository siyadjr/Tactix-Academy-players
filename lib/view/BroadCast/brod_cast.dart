import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/view/BroadCast/Widgets/broad_cast_empty.dart';
import 'package:tactix_academy_players/view/BroadCast/Widgets/broad_cast_error_message.dart';
import 'package:tactix_academy_players/view/BroadCast/Widgets/broad_cast_heading.dart';
import 'package:tactix_academy_players/view/BroadCast/Widgets/broad_cast_message_card.dart';
import 'package:intl/intl.dart';

class BroadCastAnnouncement extends StatelessWidget {
  const BroadCastAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [mainBackground!, mainBackground.withOpacity(0.4)],
            ),
          ),
          child: Column(
            children: [
              const BroadcastHeading(),
              Expanded(
                child: FutureBuilder<String>(
                  future: UserDatabase().getTeamId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data == null) {
                      return BroadcastErrorMessage();
                    }

                    final teamId = snapshot.data!;

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Teams')
                          .doc(teamId)
                          .collection('Broadcast')
                          .orderBy('timestamp', descending: false)
                          .snapshots(),
                      builder: (context, broadcastSnapshot) {
                        if (broadcastSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                    color: Colors.white),
                                const SizedBox(height: 16),
                                Text(
                                  'Loading announcements...',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (!broadcastSnapshot.hasData ||
                            broadcastSnapshot.data!.docs.isEmpty) {
                          return BroadcastEmpty();
                        }

                        final messages = broadcastSnapshot.data!.docs;
                        String currentDate = '';

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final timestamp = message['timestamp'] as Timestamp;
                            final DateTime messageDate = timestamp.toDate();

                            // Get date header
                            final String dateHeader =
                                _getDateHeader(messageDate);

                            // Check if we need to show a new date header
                            final bool showDateHeader =
                                dateHeader != currentDate;
                            if (showDateHeader) {
                              currentDate = dateHeader;
                            }

                            return Column(
                              children: [
                                if (showDateHeader)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.grey[800]!.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        dateHeader,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                AnimatedContainer(
                                  duration: Duration(
                                      milliseconds: 300 + (index * 100)),
                                  curve: Curves.easeOut,
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: BroadcastMessageCard(
                                    sender: 'Manager',
                                    formattedTime:
                                        _formatMessageTime(messageDate),
                                    message: message,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDateHeader(DateTime messageDate) {
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
}
