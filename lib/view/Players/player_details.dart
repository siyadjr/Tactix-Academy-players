import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/player_details_provider.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/model/playermodel.dart';
import 'package:tactix_academy_players/view/Players/Widgets/player_achievements_section.dart';
import 'package:tactix_academy_players/view/Players/Widgets/player_stat_section.dart';

import 'Widgets/player_profile_card.dart';

class PlayerDetails extends StatelessWidget {
  final PlayerModel player;
  const PlayerDetails({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayerDetailsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getAchievement(player.id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          player.name,
          style: const TextStyle(
              color: defaultTextColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<PlayerDetailsProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: () => provider.getAchievement(player.id),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: Column(
                children: [
                  ProfileCard(player: player),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  StatsSection(player: player),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AchievementsSection(provider: provider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
