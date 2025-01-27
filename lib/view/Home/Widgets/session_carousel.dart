import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/session_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/model/session_model.dart';
import 'package:tactix_academy_players/view/Home/Widgets/session_carousel_empty.dart';

import 'package:tactix_academy_players/view/Sessions/Widgets/session_carousel_error.dart';
import 'package:tactix_academy_players/view/Sessions/Widgets/session_carousel_items.dart';

class SessionCarousel extends StatelessWidget {
  const SessionCarousel({super.key});

  String _formatDate(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double carouselHeight = screenHeight * 0.25;

    return Consumer<SessionProvider>(
      builder: (context, sessionProvider, child) {
        if (sessionProvider.isLoading) {
          return const LoadingIndicator();
        }

        if (sessionProvider.error != null) {
          return const SessionCarouselError();
        }

        if (sessionProvider.sessions.isEmpty) {
          return const NoSessionsPlaceholder();
        }

        return CarouselSlider(
          options: CarouselOptions(
            height: carouselHeight,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            aspectRatio: 16 / 9,
            initialPage: 0,
            enableInfiniteScroll: sessionProvider.sessions.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
          ),
          items: sessionProvider.sessions.map((session) {
            return SessionCarouselItem(
                session: session, formatDate: _formatDate);
          }).toList(),
        );
      },
    );
  }
}
