import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class AttendanceTimeOver extends StatelessWidget {
  const AttendanceTimeOver({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.05;
    final double iconSize = size.width * 0.15;

    return SlideInDown(
      preferences: const AnimationPreferences(
        duration: Duration(milliseconds: 800),
        offset: Duration(milliseconds: 100),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [warningcolor.shade50, defaultTextColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: warningcolor.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: warningcolor.withOpacity(0.1),
                ),
              ),
              Positioned(
                left: -15,
                bottom: -15,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: warningcolor.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding * 1.2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeartBeat(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 1500),
                        autoPlay: AnimationPlayStates.Loop,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(padding * 0.8),
                        decoration: BoxDecoration(
                          color: warningcolor.shade50,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: warningcolor.shade300,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: warningcolor.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.timer_off_rounded,
                          size: iconSize,
                          color: warningcolor.shade700,
                        ),
                      ),
                    ),
                    SizedBox(height: padding),
                    FadeInUp(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 600),
                        offset: Duration(milliseconds: 400),
                      ),
                      child: Text(
                        'Time Over!',
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w800,
                          color: warningcolor.shade800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: padding * 0.6),
                    FadeInUp(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 600),
                        offset: Duration(milliseconds: 600),
                      ),
                      child: Text(
                        'Please ensure to mark your attendance on time',
                        style: TextStyle(
                          fontSize: size.width * 0.038,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: padding),
                    FadeInUp(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 600),
                        offset: Duration(milliseconds: 800),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding * 0.8,
                          vertical: padding * 0.6,
                        ),
                        decoration: BoxDecoration(
                          color: defaultTextColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: warningcolor.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.support_agent_rounded,
                              color: warningcolor.shade700,
                              size: size.width * 0.05,
                            ),
                            SizedBox(width: padding * 0.4),
                            Text(
                              'Contact Your Manager',
                              style: TextStyle(
                                color: warningcolor.shade700,
                                fontSize: size.width * 0.035,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
