import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';
import 'package:tactix_academy_players/view/Home/Widgets/session_carousel.dart';
import 'package:tactix_academy_players/view/Home/Widgets/players_data_simple_list.dart';
import 'package:tactix_academy_players/view/Home/Widgets/team_status_widget.dart';
import 'package:tactix_academy_players/view/Home/Widgets/welcome_title.dart';
import 'package:tactix_academy_players/view/Players/all_team_players.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Use extension for cleaner MediaQuery access
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);

    // Calculate safe area heights
    final safeVerticalPadding = padding.top + padding.bottom;
    final contentHeight = size.height - safeVerticalPadding;

    return CustomScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: contentHeight * 0.02,
            horizontal: size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeTitle(),
              // SizedBox(height: contentHeight * 0.02),
              FadeIn(
                preferences: const AnimationPreferences(
                  duration: Duration(milliseconds: 800),
                ),
                child: const SessionCarousel(),
              ),
              // SizedBox(height: contentHeight * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Team Players',
                        style: basicTextStyle.copyWith(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const AllTeamPlayers()));
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(color: secondaryTextColor),
                        ),
                      ),
                    ],
                  ),
                  const PlayersSimpleDataList(),
                  const SizedBox(
                    height: 10,
                  ),
                  const TeamStatusWidgetNew(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
