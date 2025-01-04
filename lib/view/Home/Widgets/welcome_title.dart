import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/screen_home_controller.dart';
import 'package:tactix_academy_players/view/BroadCast/brod_cast.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the fetch action when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScreenHomeController>(context, listen: false)
          .fetchTeamNameAndPhoto();
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              Consumer<ScreenHomeController>(
                builder: (context, teamProvider, child) {
                  return Text(
                    teamProvider.teamName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const BroadCastAnnouncement()));
                  },
                  icon: const Icon(
                    Icons.campaign_rounded,
                    color: Colors.yellow,
                  )),
              IconButton(
                onPressed: () {
                  debugPrint("Leaderboard Icon Pressed");
                },
                icon: const Icon(
                  Icons.format_list_numbered_sharp,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  debugPrint("Profile Icon Pressed");
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
