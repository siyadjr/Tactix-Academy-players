import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/screen_home_controller.dart';
import 'package:tactix_academy_players/controller/Controllers/team_status_provider.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';
import 'package:tactix_academy_players/view/Attendance/attendance.dart';
import 'package:tactix_academy_players/view/Payments/payment.dart';

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
        _buildHeader(size),
        _buildQuickAccess(context, size),
        _buildPayments(context, size),
        _buildStatsPageView(context, size),
        _buildPageIndicator(context),
      ],
    );
  }

  Widget _buildHeader(Size size) {
    return Text(
      'Team Overview',
      style: basicTextStyle.copyWith(
        fontSize: size.width * 0.044,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildStatsPageView(BuildContext context, Size size) {
    final mainCards = [
      (
        title: 'Top Scorers',
        icon: FontAwesomeIcons.futbol,
        color: Colors.orange,
        routeName: '/scorers'
      ),
      (
        title: 'Top Assists',
        icon: FontAwesomeIcons.handshake,
        color: Colors.blue,
        routeName: '/assists'
      ),
      (
        title: 'Top Rated',
        icon: FontAwesomeIcons.star,
        color: Colors.purple,
        routeName: '/ratings'
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
            child: _GridCard(
              title: card.title,
              icon: card.icon,
              color: card.color,
              onTap: () {
                debugPrint('Navigate to: ${card.routeName}');
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickAccess(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.04),
      child: Row(
        children: [
          Expanded(
            child: _QuickAccessCard(
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
            child: _QuickAccessCard(
              title: 'Payments',
              subtitle: 'Payment Records ',
              icon: Icons.payment,
              gradientColors: const [Colors.green, Colors.red],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PaymentScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPayments(BuildContext context, Size size) {
  return Padding(
    padding: EdgeInsets.all(size.width * 0.04),
    child: Row(
      children: [
        Expanded(
          child: Consumer<ScreenHomeController>(
            builder: (context, teamDetails, child) => _QuickAccessCard(
              title: teamDetails.teamName,
              subtitle: 'Team profile',
              icon: Icons.shield_rounded,
              gradientColors: const [Colors.red, Colors.deepOrange],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PaymentScreen()),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

class _GridCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _GridCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1.5,
            ),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.2),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: color,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPageIndicator(BuildContext context) {
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

class _QuickAccessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                gradientColors[0].withOpacity(0.2),
                gradientColors[1].withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: gradientColors[0].withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: gradientColors[0].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: gradientColors[0],
                  size: 20,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.fade),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
