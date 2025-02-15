import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:tactix_academy_players/controller/Controllers/team_profile_provider.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class TeamProfileManagerLicense extends StatelessWidget {
  const TeamProfileManagerLicense({
    super.key,
    required this.provider,
  });

  final TeamProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.team!.teamManager.licenseUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manager License',
              style: TextStyle(
                fontSize: 18,
                color: secondaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                provider.team!.teamManager.licenseUrl,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}






