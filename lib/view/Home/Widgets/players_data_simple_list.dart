import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/screen_home_controller.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class PlayersSimpleDataList extends StatelessWidget {
  const PlayersSimpleDataList({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Consumer<ScreenHomeController>(
        builder: (context, teamProvider, child) {
          // Ensure player photos are fetched if not already loaded
          if (teamProvider.playersPhotos.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<ScreenHomeController>(context, listen: false)
                  .fetchTeamNameAndPhoto();
            });
          }

          // Display the list of player photos
          return teamProvider.playersPhotos.isEmpty
              ? const Text(
                  'No Players',
                  style: TextStyle(color: defaultTextColor),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: teamProvider.playersPhotos.length,
                  itemBuilder: (context, index) {
                    final photoUrl = teamProvider.playersPhotos[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        image: DecorationImage(
                          image: NetworkImage(photoUrl),
                          fit: BoxFit.cover,
                          onError: (_, __) {
                            debugPrint('Failed to load image at $photoUrl');
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
