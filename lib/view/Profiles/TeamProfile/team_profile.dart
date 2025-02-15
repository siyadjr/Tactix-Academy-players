import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/controller/Controllers/team_profile_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Profiles/TeamProfile/Widgets/team_profile_build_stat.dart';
import 'package:tactix_academy_players/view/Profiles/TeamProfile/Widgets/team_profile_empty_state.dart';
import 'package:tactix_academy_players/view/Profiles/TeamProfile/Widgets/team_profile_header.dart';
import 'package:tactix_academy_players/view/Profiles/TeamProfile/Widgets/team_profile_manager_license.dart';

class TeamProfile extends StatelessWidget {
  const TeamProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeamProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getTeamDetails();
    });

    return Consumer<TeamProfileProvider>(
      builder: (context, teamProvider, child) => CustomScaffold(
        appBar: AppBar(),
        body: provider.isLoading
            ? const Center(child: LoadingIndicator())
            : provider.team == null
                ? const TeamProfileEmptyState()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        TeamProfileHeader(context: context, provider: provider),
                        TeamProfileBuildStat(provider: provider),
                        TeamProfileManagerLicense(provider: provider),
                        FadeInUp(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: OutlinedButton.icon(
                              onPressed: () =>
                                  _showLeaveTeamDialog(context, provider),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.exit_to_app),
                              label: const Text(
                                'Leave Team',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Future<void> _showLeaveTeamDialog(
      BuildContext context, TeamProfileProvider provider) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Team'),
        content: const Text(
          'Are you sure you want to leave this team? This action cannot be undone.',
          style: TextStyle(color: secondaryTextColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await provider.leftFromTeam(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('You have successfully left the team.')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}
