import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/controller/Controllers/attendance_provider.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class AttendancePunchButton extends StatelessWidget {
  const AttendancePunchButton({
    super.key,
    required this.provider,
  });

  final AttendanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideInDown(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(
                      "Time left: ${provider.remainingTime}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Pulse(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    provider.punchAttendance();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade400,
                          Colors.green.shade600,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.fingerprint,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            FadeInUp(
              child: const Text(
                "Tap to Mark Attendance",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            FadeInUp(
              child: Text(
                "Make sure you're at the right location",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
