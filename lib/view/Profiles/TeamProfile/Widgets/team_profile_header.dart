import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/controller/Controllers/team_profile_provider.dart';

class TeamProfileHeader extends StatelessWidget {
  const TeamProfileHeader({
    super.key,
    required this.context,
    required this.provider,
  });

  final BuildContext context;
  final TeamProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        children: [
          // Team Logo
          FadeInLeft(
            child: Hero(
              tag: 'team-logo',
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: provider.team!.teamPhoto.isNotEmpty
                      ? Image.network(
                          provider.team!.teamPhoto,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.sports_soccer,
                          size: 60,
                          color: Colors.grey,
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Manager Profile
          Expanded(
            child: FadeInRight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.team!.teamName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            provider.team!.teamManager.userProfile.isNotEmpty
                                ? NetworkImage(
                                    provider.team!.teamManager.userProfile)
                                : null,
                        child: provider.team!.teamManager.userProfile.isEmpty
                            ? const Icon(Icons.person, color: Colors.grey)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manager',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text(
                            provider.team!.teamManager.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}