import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/playermodel.dart';

class ProfileCard extends StatelessWidget {
  final PlayerModel player;
  const ProfileCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          children: [
            Hero(
              tag: 'player_avatar_${player.id}',
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.12,
                backgroundImage: player.userProfile.isNotEmpty
                    ? NetworkImage(player.userProfile)
                    : null,
                child: player.userProfile.isEmpty
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              player.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              player.email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
