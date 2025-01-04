import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';
import 'package:tactix_academy_players/model/playermodel.dart';
import 'package:tactix_academy_players/view/Home/Widgets/events_carousel.dart';
import 'package:tactix_academy_players/view/Home/Widgets/players_data_simple_list.dart';
import 'package:tactix_academy_players/view/Home/Widgets/team_status_widget.dart';
import 'package:tactix_academy_players/view/Home/Widgets/welcome_title.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "assets/Tactix app logo.jpg",
      "assets/Tactix app logo.jpg",
      "assets/Tactix app logo.jpg",
      "assets/Tactix app logo.jpg",
      "assets/Tactix app logo.jpg",
      "assets/Tactix app logo.jpg",
      "assets/Tactix app logo.jpg",
    ];

    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const WelcomeTitle(),
            const SizedBox(height: 20),
            FadeIn(child: EventCarousel()),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Team Players',
                        style: basicTextStyle,
                      ),
                      const Text(
                        'See all',
                        style: TextStyle(color: secondaryTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PlayersSimpleDataList(items: items),
                  const SizedBox(
                    height: 20,
                  ),
                  const TeamStatusWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
