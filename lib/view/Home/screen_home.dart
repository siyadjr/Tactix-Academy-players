import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';
import 'package:tactix_academy_players/view/Home/Widgets/session_carousel.dart';
import 'package:tactix_academy_players/view/Home/Widgets/players_data_simple_list.dart';
import 'package:tactix_academy_players/view/Home/Widgets/team_status_widget.dart';
import 'package:tactix_academy_players/view/Home/Widgets/welcome_title.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScaffold(
      body: SingleChildScrollView(
        // Wrap the body in SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            const WelcomeTitle(),
            SizedBox(height: screenHeight * 0.02),
            FadeIn(child: const SessionCarousel()),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05), // Adjust padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Team Players',
                        style: basicTextStyle.copyWith(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Text( 
                        'See all',
                        style: TextStyle(color: secondaryTextColor),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01), // Adjust height
                  const PlayersSimpleDataList(),
                  SizedBox(height: screenHeight * 0.02), // Adjust height
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
