import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/chat_hub_provider.dart';
import 'package:tactix_academy_players/model/manager_model.dart';
import 'package:tactix_academy_players/model/playermodel.dart';
import 'package:tactix_academy_players/view/ChatHub/Widgets/chat_screen_app_bar.dart';
import 'package:tactix_academy_players/view/ChatHub/Widgets/chat_screen_message_content.dart';

class ChatScreen extends StatelessWidget {
  final dynamic userModel;

  const ChatScreen({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatHubProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;

    final currentUser = ChatUser(
      id: user?.uid ?? "unknown",
      firstName: user?.displayName ?? "Me",
      profileImage: user?.photoURL,
    );

    ChatUser opponentUser;
    String opponentId = "";
    String opponentName = "";
    String opponentProfile = "";

    if (userModel is PlayerModel) {
      opponentUser = ChatUser(
        id: userModel.id,
        firstName: userModel.name,
        profileImage: userModel.userProfile,
      );
      opponentId = userModel.id;
      opponentName = userModel.name;
      opponentProfile = userModel.userProfile;
    } else if (userModel is ManagerModel) {
      opponentUser = ChatUser(
        id: userModel.id,
        firstName: userModel.name,
        profileImage: userModel.userProfile,
      );
      opponentId = userModel.id;
      opponentName = userModel.name;
      opponentProfile = userModel.userProfile;
    } else {
      throw Exception("Invalid user model type");
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ChatScreenAppBar(
              opponentName: opponentName, opponentProfile: opponentProfile),
          chatScreenMessageContent(
              chatProvider: chatProvider,
              opponentId: opponentId,
              currentUser: currentUser,
              opponentUser: opponentUser,
              opponentProfile: opponentProfile,
              user: user),
        ],
      ),
    );
  }
}
