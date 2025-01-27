import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/attention_seekers/pulse.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/chat_hub_provider.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/ChatHub/chat_screen.dart';

class ChatHubManagerContainer extends StatelessWidget {
  const ChatHubManagerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatHubProvider>(
      builder: (context, chatHubProvider, child) {
        return GestureDetector(
          onTap: chatHubProvider.manager != null
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          ChatScreen(userModel: chatHubProvider.manager!),
                    ),
                  )
              : null,
          child: Pulse(
            child: Container(
              height: 170,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF1E245A), Color(0xFF131A42)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
                border: Border.all(
                    color: Colors.blueAccent.withOpacity(0.5), width: 1),
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: chatHubProvider.manager != null
                            ? NetworkImage(chatHubProvider.manager!.userProfile)
                            : null,
                        child: chatHubProvider.manager == null
                            ? const Icon(Icons.person,
                                color: Colors.grey, size: 40)
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chatHubProvider.manager?.name ?? 'No Manager',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Team Manager',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 160,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ChatScreen(
                                            userModel: chatHubProvider.manager,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: Colors.blueAccent,
                              // foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              elevation: 5,
                            ),
                            icon:
                                const Icon(Icons.chat_bubble_outline, size: 18),
                            label: const Text(
                              'Chat with Manager',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: secondaryTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
