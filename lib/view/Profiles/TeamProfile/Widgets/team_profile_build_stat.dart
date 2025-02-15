import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:tactix_academy_players/controller/Controllers/team_profile_provider.dart';
import 'package:tactix_academy_players/view/Profiles/TeamProfile/Widgets/team_profile_stat.dart';

class TeamProfileBuildStat extends StatelessWidget {
  const TeamProfileBuildStat({
    super.key,
    required this.provider,
  });

  final TeamProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            TeamProfileStat(
                icon: Icons.location_on,
                iconColor: Colors.red,
                title: 'Location',
                value: provider.team!.teamLocation),
            const Divider(height: 24),
            TeamProfileStat(
                icon: Icons.people,
                iconColor: Colors.blue,
                title: 'Squad Size',
                value: '${provider.team!.teamPlayersCount} players'),
          ],
        ),
      ),
    );
  }
}
