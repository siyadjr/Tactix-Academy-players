import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';

class NoSessionsPlaceholder extends StatelessWidget {
  const NoSessionsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[700]!,
              Colors.purple[700]!,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/ChatHub image.png',
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.2),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 48,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Sessions Scheduled',
                    style: basicTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check back later for upcoming events',
                    style: basicTextStyle.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
