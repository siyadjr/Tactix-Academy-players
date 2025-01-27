import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tactix_academy_players/controller/Controllers/chat_hub_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/model/chat_model.dart';

class chatScreenMessageContent extends StatelessWidget {
  const chatScreenMessageContent({
    super.key,
    required this.chatProvider,
    required this.opponentId,
    required this.currentUser,
    required this.opponentUser,
    required this.opponentProfile,
    required this.user,
  });

  final ChatHubProvider chatProvider;
  final String opponentId;
  final ChatUser currentUser;
  final ChatUser opponentUser;
  final String opponentProfile;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: StreamBuilder<List<ChatModel>>(
        stream: chatProvider.getMessages(opponentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          }
    
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
    
          final messages = snapshot.data ?? [];
    
          return DashChat(
            currentUser: currentUser,
            messageOptions: MessageOptions(
              showTime: true,
              timeFormat: DateFormat('hh:mm a'),
              currentUserContainerColor: Colors.deepPurple[300],
              containerColor: Colors.grey.shade200,
              textColor: Colors.black,
              showOtherUsersAvatar: true,
              avatarBuilder: (user, size, onTap) {
                if (user.id == opponentUser.id) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(opponentProfile),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            messages: messages.map((msg) {
              return ChatMessage(
                text: msg.message,
                user:
                    msg.sender == user?.uid ? currentUser : opponentUser,
                createdAt: DateTime.parse(msg.time),
              );
            }).toList(),
            onSend: (ChatMessage message) {
              chatProvider.sendMessage(message.text, opponentId);
    
            },
            inputOptions: InputOptions(
              sendButtonBuilder: (onSend) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 4, right: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple[300]!,
                        Colors.deepPurple[500]!
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: onSend,
                  ),
                );
              },
              inputTextStyle: const TextStyle(color: Colors.black),
              inputDecoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),
              ),
            ),
          );
        },
      ),
    );
  }
}

