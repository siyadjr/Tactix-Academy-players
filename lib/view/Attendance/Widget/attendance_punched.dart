import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class AttendancePunched extends StatelessWidget {
  const AttendancePunched({super.key});

  @override
  Widget build(BuildContext context) {
    final double iconSize = 60.0; // Standardized icon size

    return SingleChildScrollView(
      child: BounceInDown(
        preferences: const AnimationPreferences(
          duration: Duration(milliseconds: 800),
          offset: Duration(milliseconds: 100),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successcolor.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: successcolor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HeartBeat(
                  preferences: const AnimationPreferences(
                    duration: Duration(milliseconds: 1500),
                    autoPlay: AnimationPlayStates.Loop,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: successcolor.shade50,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: successcolor.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: successcolor.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle_outline,
                      size: iconSize,
                      color: successcolor.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FadeInUp(
                  child: const Text(
                    'Successfully Punched In!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.green,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                FadeInUp(
                  child: Text(
                    'Show all of them what you got!',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: textColor,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16.0),
                SlideInUp(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: successcolor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: successcolor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: successcolor.shade700,
                          size: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'On Time',
                          style: TextStyle(
                            color: successcolor.shade700,
                            fontSize: 14.0,
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
        ),
      ),
    );
  }
}
