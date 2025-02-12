import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/playermodel.dart';
import 'package:tactix_academy_players/view/Players/Widgets/player_stat_card.dart';

class StatsSection extends StatelessWidget {
  final PlayerModel player;
  const StatsSection({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Player Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                StatCard(title: 'Number', value: player.number),
                const SizedBox(width: 16),
                StatCard(title: 'Position', value: player.position),
              ],
            ),
            const SizedBox(height: 16),
            Row(children: [StatCard(title: 'Fitness', value: player.fit)]),
          ],
        ),
      ),
    );
  }
}
