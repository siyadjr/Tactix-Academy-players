import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/screen_home_controller.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class PlayersSimpleDataList extends StatelessWidget {
  const PlayersSimpleDataList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenWidth * 0.3, // Adjust height based on screen width
      child: Consumer<ScreenHomeController>(
        builder: (context, teamProvider, child) {
          if (teamProvider.playersPhotos.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Provider.of<ScreenHomeController>(context, listen: false)
                  .fetchTeamNameAndPhoto();
            });
          }

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

                    return Row(
                      children: [
                        SizedBox(
                            width:
                                screenWidth * 0.02), // Adjust width for spacing
                        CircleAvatar(
                          radius: screenWidth *
                              0.1, // Adjust the radius of the avatar
                          backgroundImage: NetworkImage(photoUrl),
                          onBackgroundImageError: (exception, stackTrace) {
                            // Return a widget in case of error
                            const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
