import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class NoAttendanceDay extends StatelessWidget {
  const NoAttendanceDay({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.05;
    final double iconSize = size.width * 0.16;

    return ZoomIn(
      preferences: const AnimationPreferences(
        duration: Duration(milliseconds: 800),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade50,
              Colors.white,
              Colors.teal.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Decorative elements
              Positioned(
                right: -30,
                top: -30,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.teal.withOpacity(0.1),
                ),
              ),
              Positioned(
                left: -20,
                bottom: -20,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.teal.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding * 1.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SlideInDown(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 800),
                        offset: Duration(milliseconds: 200),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.teal.shade200,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.spa,
                          size: iconSize,
                          color: Colors.teal.shade400,
                        ),
                      ),
                    ),
                    SizedBox(height: padding * 1.2),
                    FadeInUp(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 600),
                        offset: Duration(milliseconds: 400),
                      ),
                      child: Text(
                        "No Attendance Required Today",
                        style: TextStyle(
                          fontSize: size.width * 0.0652,
                          fontWeight: FontWeight.w800,
                          color: Colors.teal.shade700,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: padding * 0.8),
                    FadeInUp(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 600),
                        offset: Duration(milliseconds: 600),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding * 1.2,
                          vertical: padding * 0.6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.teal.shade100,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.beach_access_rounded,
                              size: size.width * 0.05,
                              color: Colors.teal.shade400,
                            ),
                            SizedBox(width: padding * 0.4),
                            Text(
                              "Enjoy your day off!",
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.teal.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: padding * 0.8),
                    FadeInUp(
                      preferences: const AnimationPreferences(
                        duration: Duration(milliseconds: 600),
                        offset: Duration(milliseconds: 800),
                      ),
                      child: Text(
                        "See you on your next Match day!",
                        style: TextStyle(
                          fontSize: size.width * 0.035,
                          color: Colors.teal.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
