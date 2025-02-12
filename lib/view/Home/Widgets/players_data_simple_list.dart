import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/screen_home_controller.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

class PlayersSimpleDataList extends StatelessWidget {
  const PlayersSimpleDataList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final avatarSize = size.width * 0.13;

    return SizedBox(
      height: avatarSize * 1.2,
      child: Consumer<ScreenHomeController>(
        builder: (context, teamProvider, _) {
          if (teamProvider.playersPhotos.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ScreenHomeController>().fetchTeamNameAndPhoto();
            });

            return const Center(
              child: Text(
                'No Players',
                style: TextStyle(
                  color: defaultTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: teamProvider.playersPhotos.length,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.01,
            ),
            separatorBuilder: (_, __) => SizedBox(width: size.width * 0.03),
            itemBuilder: (context, index) {
              return _buildPlayerAvatar(
                photoUrl: teamProvider.playersPhotos[index],
                size: avatarSize,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPlayerAvatar({
    required String photoUrl,
    required double size,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.grey[200],
        backgroundImage: NetworkImage(photoUrl),
        onBackgroundImageError: (_, __) => const Icon(
          Icons.person,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }
}
