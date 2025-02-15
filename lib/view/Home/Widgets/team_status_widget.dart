import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/screen_home_controller.dart';
import 'package:tactix_academy_players/controller/Controllers/team_status_provider.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';
import 'package:tactix_academy_players/view/Attendance/attendance.dart';
import 'package:tactix_academy_players/view/Home/Widgets/screen_home_gridcard.dart';
import 'package:tactix_academy_players/view/Home/Widgets/screen_home_quick_access_card.dart';
import 'package:tactix_academy_players/view/Payments/payment.dart';
import 'package:tactix_academy_players/view/Players/player_assisters.dart';
import 'package:tactix_academy_players/view/Players/player_ranking.dart';
import 'package:tactix_academy_players/view/Players/player_topscorers.dart';
import 'package:tactix_academy_players/view/Profiles/TeamProfile/team_profile.dart';

class TeamStatusWidgetNew extends StatelessWidget {
  const TeamStatusWidgetNew({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScreenHomeController>().fetchTeamNameAndPhoto();
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(size),
        buildQuickAccess(context, size),
        buildPayments(context, size),
        buildStatsPageView(context, size),
        buildPageIndicator(context),
      ],
    );
  }

  Widget buildHeader(Size size) {
    return Text(
      'Team Overview',
      style: basicTextStyle.copyWith(
        fontSize: size.width * 0.044,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget buildStatsPageView(BuildContext context, Size size) {
    final mainCards = [
      (
        title: 'Top Scorers',
        icon: FontAwesomeIcons.futbol,
        color: Colors.orange,
        nextPage: PlayerTopScorers()
      ),
      (
        title: 'Top Assists',
        icon: FontAwesomeIcons.handshake,
        color: Colors.blue,
        nextPage: PlayerAssisters()
      ),
      (
        title: 'Top Rated',
        icon: FontAwesomeIcons.star,
        color: Colors.purple,
        nextPage: PlayerRanking()
      ),
    ];

    return SizedBox(
      height: size.height * 0.2,
      child: PageView.builder(
        onPageChanged: (index) =>
            context.read<TeamStatusProvider>().setCurrentPage(index),
        itemCount: mainCards.length,
        itemBuilder: (context, index) {
          final card = mainCards[index];
          return Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: GridCard(
              title: card.title,
              icon: card.icon,
              color: card.color,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => card.nextPage));
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildQuickAccess(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.04),
      child: Row(
        children: [
          Expanded(
            child: QuickAccessCard(
              title: 'Attendance',
              subtitle: 'Track Records',
              icon: Icons.calendar_today_rounded,
              gradientColors: const [Colors.teal, Colors.cyan],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Attendance()),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: QuickAccessCard(
              title: 'Payments',
              subtitle: 'Payment Records ',
              icon: Icons.payment,
              gradientColors: const [Colors.green, Colors.red],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildPayments(BuildContext context, Size size) {
  return Padding(
    padding: EdgeInsets.all(size.width * 0.04),
    child: Row(
      children: [
        Expanded(
          child: Consumer<ScreenHomeController>(
            builder: (context, teamDetails, child) => QuickAccessCard(
              title: teamDetails.teamName,
              subtitle: 'Team profile',
              icon: Icons.shield_rounded,
              gradientColors: const [Colors.red, Colors.deepOrange],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TeamProfile()),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildPageIndicator(BuildContext context) {
  return Consumer<TeamStatusProvider>(
    builder: (context, provider, _) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: provider.currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: provider.currentPage == index
                ? Colors.white
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ),
  );
}
