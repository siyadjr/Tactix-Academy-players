import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/widgets/bouncing_entrances/bounce_in.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:flutter_animator/widgets/sliding_entrances/slide_in_left.dart';
import 'package:tactix_academy_players/core/Important/shared_preference.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Theme/text_style.dart';
import 'package:tactix_academy_players/view/Home/screen_home.dart';
import 'package:tactix_academy_players/view/Teams/Screens/all_teams.dart';
import 'package:tactix_academy_players/view/Teams/Widgets/search_teams_by_teamid.dart';

class JoinTeams extends StatelessWidget {
  JoinTeams({super.key});

  final TextEditingController _teamIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Players')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }

        if (snapshot.hasData && snapshot.data != null) {
          final playerData = snapshot.data!.data() as Map<String, dynamic>;

          // Check if `teamId` is assigned
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (playerData.containsKey('teamId') &&
                playerData['teamId'] != "Not Assigned") {
              SharedPreferenceDatas().sharedPrefSignIn();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => const ScreenHome()),
                (_) => false,
              );
            }
          });
        }

        return CustomScaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInDown(
                        preferences: const AnimationPreferences(
                          duration: Duration(milliseconds: 1000),
                        ),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.3,
                          backgroundImage:
                              const AssetImage('assets/Tactix app logo.jpg'),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      FadeInUp(
                        preferences: const AnimationPreferences(
                          duration: Duration(milliseconds: 800),
                        ),
                        child: Text(
                          'Welcome User',
                          style: headingStyle.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FadeIn(
                        preferences: const AnimationPreferences(
                          duration: Duration(milliseconds: 800),
                        ),
                        child: Text(
                          'Enter Your TEAM ID to Join Your ELITE SQUAD',
                          style: subHeadingStyle.copyWith(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      SlideInLeft(
                        preferences: const AnimationPreferences(
                          duration: Duration(milliseconds: 900),
                        ),
                        child: SearchingTeamsById(
                            teamIdController: _teamIdController),
                      ),
                      const SizedBox(height: 16.0),
                      BounceIn(
                        preferences: const AnimationPreferences(
                          duration: Duration(milliseconds: 700),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const AllTeams()));
                          },
                          child: const Text(
                            'View Teams',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
