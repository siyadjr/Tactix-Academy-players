import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/chat_hub_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/ChatHub/Widgets/chat_hub_manager_container.dart';
import 'package:tactix_academy_players/view/ChatHub/chat_screen.dart';

class Chathub extends StatelessWidget {
  const Chathub({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatHubProvider>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    final bool isTablet = size.width > 600;
    final double paddingSize = size.width * 0.04;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchAllPlayers();
      provider.fetchManager();
    });

    return CustomScaffold(
      appBar: AppBar(
        title: FadeIn(
          child: Text(
            'Chat Hub',
            style: TextStyle(
              color: defaultTextColor,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.05,
              letterSpacing: 1.2,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [mainBackground, mainBackground.withOpacity(0.9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              mainBackground.withOpacity(0.1),
              mainBackground.withOpacity(0.2),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            children: [
              SizedBox(
                width: isTablet ? size.width * 0.7 : size.width,
                child: const ChatHubManagerContainer(),
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: Consumer<ChatHubProvider>(
                  builder: (context, chatHubProvider, child) {
                    if (chatHubProvider.isLoading) {
                      return const Center(child: LoadingIndicator());
                    }
                    return chatHubProvider.allPlayers.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isTablet ? 2 : 1,
                              childAspectRatio: isTablet ? 2.5 : 3,
                              mainAxisSpacing: size.height * 0.015,
                              crossAxisSpacing: size.width * 0.015,
                            ),
                            itemCount: chatHubProvider.allPlayers.length,
                            itemBuilder: (context, index) {
                              final player = chatHubProvider.allPlayers[index];
                              return FadeInUp(
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      chatHubProvider.createChatRoom(player.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) =>
                                              ChatScreen(userModel: player),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            mainBackground,
                                            mainBackground.withOpacity(0.8),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(size.width * 0.03),
                                        child: Row(
                                          children: [
                                            Hero(
                                              tag: 'player_${player.id}',
                                              child: Container(
                                                width: size.width * 0.15,
                                                height: size.width * 0.15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                    ),
                                                  ],
                                                ),
                                                child: ClipOval(
                                                  child: Image.network(
                                                    player.userProfile,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: size.width * 0.04),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    player.name,
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.045,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: defaultTextColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          size.height * 0.01),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 0.02,
                                                      vertical:
                                                          size.height * 0.005,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: mainBackground
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      player.position,
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.035,
                                                        color:
                                                            secondaryTextColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: defaultTextColor,
                                              size: size.width * 0.05,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_off_outlined,
                                  size: size.width * 0.15,
                                  color: secondaryTextColor,
                                ),
                                SizedBox(height: size.height * 0.02),
                                Text(
                                  'No players available',
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
