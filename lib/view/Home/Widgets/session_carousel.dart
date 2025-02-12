import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/session_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/view/Home/Widgets/session_carousel_empty.dart';
import 'package:tactix_academy_players/view/Sessions/Widgets/session_carousel_error.dart';
import 'package:tactix_academy_players/view/Sessions/Widgets/session_carousel_items.dart';

class SessionCarousel extends StatelessWidget {
  const SessionCarousel({super.key});

  String _formatDate(String date) {
    final dateTime = DateTime.parse(date);
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final carouselHeight = size.height * 0.28;

    return Consumer<SessionProvider>(
      builder: (context, sessionProvider, _) {
        if (sessionProvider.isLoading) {
          return SizedBox(
            height: carouselHeight,
            child: const Center(child: LoadingIndicator()),
          );
        }

        if (sessionProvider.error != null) {
          return SizedBox(
            height: carouselHeight,
            child: const SessionCarouselError(),
          );
        }

        if (sessionProvider.sessions.isEmpty) {
          return SizedBox(
            height: carouselHeight,
            child: const NoSessionsPlaceholder(),
          );
        }

        return CarouselSlider.builder(
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
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
          itemCount: sessionProvider.sessions.length,
          itemBuilder: (context, index, realIndex) {
            final session = sessionProvider.sessions[index];
            return SessionCarouselItem(
              session: session,
              formatDate: _formatDate,
            );
          },
        );
      },
    );
  }
}
