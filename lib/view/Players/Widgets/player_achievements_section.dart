import 'package:flutter/material.dart';
import 'package:tactix_academy_players/controller/Controllers/player_details_provider.dart';

class AchievementsSection extends StatelessWidget {
  final PlayerDetailsProvider provider;
  const AchievementsSection({super.key, required this.provider});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Achievements',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800])),
                if (provider.isLoading)
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2)),
              ],
            ),
            const SizedBox(height: 16),
            provider.achievements.isEmpty
                ? const Center(
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No achievements yet',
                            style:
                                TextStyle(fontSize: 16, color: Colors.grey))))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.achievements.length,
                    itemBuilder: (context, index) {
                      final achievement = provider.achievements[index];
                      return ListTile(
                        leading:
                            const CircleAvatar(child: Icon(Icons.emoji_events)),
                        title: Text(
                            achievement['name'] ?? 'Unknown Achievement',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Count: ${achievement['count'] ?? '0'}',
                            style: TextStyle(color: Colors.grey[600])),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
