import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/team_controller.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';

class AllTeams extends StatelessWidget {
  const AllTeams({super.key});

  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProviderController>(context);

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FadeInLeft(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (query) {
                        teamProvider.filterTeams(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for a team...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white12,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Display teams
            Expanded(
              child: teamProvider.filteredTeams.isNotEmpty
                  ? ListView.builder(
                      itemCount: teamProvider.filteredTeams.length,
                      itemBuilder: (context, index) {
                        final team = teamProvider.filteredTeams[index];

                        return FadeInUp(
                          child: Card(
                            color: Colors.grey[900],
                            child: ListTile(
                              title: Text(
                                team['teamName'] ?? 'Unknown Team',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                'Location: ${team['teamLocation']}',
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No teams found.',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
