import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/team_status_provider.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';
import 'package:tactix_academy_players/view/Attendance/attendance.dart';

class TeamStatusWidget extends StatelessWidget {
  const TeamStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> teamStatus = ['Top Scorers', 'Top Assists', 'Top Rated'];
    List<IconData> icons = [
      FontAwesomeIcons.futbol,
      FontAwesomeIcons.handshake,
      FontAwesomeIcons.star,
    ];
    List<Color> gradients = gradientColours;

    return Consumer<TeamStatusProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Team Stats',
                style: basicTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                double heightFactor = constraints.maxHeight > 800
                    ? 0.8
                    : 0.7; // Adjust height based on screen size

                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 260 *
                                heightFactor, // Adjust height using heightFactor
                            child: PageView.builder(
                              onPageChanged: (index) {
                                provider.setCurrentPage(index);
                              },
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                final title = teamStatus[index];
                                final icon = icons[index];
                                final gradientColor = gradients[index];

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        gradientColor,
                                        gradientColor.withOpacity(0.7),
                                        gradientColor.withOpacity(0.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: gradientColor.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CustomPaint(
                                            painter: PatternPainter(),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 24,
                                        left: 24,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.15),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Icon(
                                            icon,
                                            size: 32,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 40,
                                        right: -20,
                                        child: Icon(
                                          icon,
                                          size: 140,
                                          color: Colors.white.withOpacity(0.07),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 24,
                                        left: 24,
                                        right: 24,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              title,
                                              style: subHeadingStyle.copyWith(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              height: 3,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                height: 8,
                                width: provider.currentPage == index ? 24 : 8,
                                decoration: BoxDecoration(
                                  color: provider.currentPage == index
                                      ? gradients[provider.currentPage]
                                      : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        buildStatBox(
                          context: context,
                          nextPage: const Attendance(),
                          title: 'Attendance',
                          image: 'assets/Attendence.jpg',
                          gradientColors: [mainBackground, Colors.black],
                        ),
                        const SizedBox(height: 10),
                        buildStatBox(
                          context: context,
                          nextPage: const Attendance(),
                          title: 'Arsenal Fc',
                          image: 'assets/RankList.png',
                          gradientColors: [mainBackground, Colors.black],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildStatBox({
    required Widget nextPage,
    required String title,
    required String image,
    required List<Color> gradientColors,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => nextPage)),
      child: Container(
        height: 110,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: subHeadingStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    for (double i = 0.0; i < size.width + size.height; i += 30) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(0, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
