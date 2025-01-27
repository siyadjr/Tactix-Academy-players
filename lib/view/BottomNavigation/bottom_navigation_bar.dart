import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/bottom_navigation_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/chat_hub_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/screen_home_controller.dart';
import 'package:tactix_academy_players/controller/Controllers/session_provider.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/ChatHub/chathub.dart';
import 'package:tactix_academy_players/view/Home/screen_home.dart';
import 'package:tactix_academy_players/view/Settings/settings.dart';
import 'package:tactix_academy_players/view/Tactix-Ai/tactix_ai.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavProvider, child) {
          // Call necessary providers when navigating
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (bottomNavProvider.selectedIndex == 2) {
              Provider.of<ChatHubProvider>(context, listen: false)
                ..fetchAllPlayers()
                ..fetchManager();
            } else if (bottomNavProvider.selectedIndex == 1) {
              Provider.of<SessionProvider>(context, listen: false)
                  .fetchSessions();
              Provider.of<ScreenHomeController>(context, listen: false)
                  .fetchPlayersPhotos();
            }
          });

          return IndexedStack(
            index: bottomNavProvider.selectedIndex,
            children: const [
              TactixAi(),
              ScreenHome(),
              Chathub(),
              Settings(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavProvider, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: GNav(
              gap: 8,
              activeColor: Colors.blue,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue.withOpacity(0.1),
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: FontAwesomeIcons.robot,
                  iconSize: 19,
                  text: 'Tactix-Ai',
                  iconColor: defaultTextColor,
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  iconColor: defaultTextColor,
                ),
                GButton(
                  icon: Icons.chat,
                  text: 'ChatHub',
                  iconColor: defaultTextColor,
                ),
                GButton(
                  icon: Icons.account_circle,
                  iconColor: defaultTextColor,
                  text: 'Profile',
                ),
              ],
              selectedIndex: bottomNavProvider.selectedIndex,
              onTabChange: (index) {
                bottomNavProvider.setSelectedIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
