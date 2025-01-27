import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class ChatScreenAppBar extends StatelessWidget {
  const ChatScreenAppBar({
    super.key,
    required this.opponentName,
    required this.opponentProfile,
  });

  final String opponentName;
  final String opponentProfile;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          opponentName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
              )
            ],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [mainBackground, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            image: DecorationImage(
              image: NetworkImage(opponentProfile),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(opponentProfile),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
