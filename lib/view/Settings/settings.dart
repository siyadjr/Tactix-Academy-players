import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/user_profile_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Authentications/SignIn/forgot_password.dart';
import 'package:tactix_academy_players/view/Settings/Widgets/user_profile_account_action.dart';
import 'package:tactix_academy_players/view/Settings/Widgets/user_profile_build_profile_card.dart';
import 'package:tactix_academy_players/view/Settings/Widgets/user_profile_gradient_card.dart';
import 'package:tactix_academy_players/view/Settings/Widgets/user_profile_setting_tile.dart';
import 'package:tactix_academy_players/view/Settings/about_.dart';
import 'package:tactix_academy_players/view/Settings/contact_us.dart';
import 'package:tactix_academy_players/view/Settings/privacy_policy.dart';
import 'package:tactix_academy_players/view/Settings/terms_and_condition.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileProvider>().getUserData();
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              mainBackground,
              Colors.black,
            ],
          ),
        ),
        child: Consumer<UserProfileProvider>(
          builder: (context, userProvider, _) {
            return CustomScrollView(
              slivers: [
                buildSliverAppBar(),
                SliverToBoxAdapter(
                  child: userProvider.isLoading
                      ? const Center(child: LoadingIndicator())
                      : Column(
                          children: [
                            UserProfileBuildProfileCard(
                                context: context, userProvider: userProvider),
                            const SizedBox(height: 24),
                            buildSettingsCard(context),
                            const SizedBox(height: 24),
                            UserProfileAccountActions(
                                context: context, userProvider: userProvider),
                            const SizedBox(height: 32),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildSliverAppBar() {
    return const SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      stretch: true,
      centerTitle: true,
      backgroundColor: mainBackground,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildSettingsCard(BuildContext context) {
    return Column(
      children: [
        BuildGradientCard(
            title: 'Account',
            icon: CupertinoIcons.settings,
            color: Colors.purple,
            child: buildSettingsTile(
              icon: CupertinoIcons.lock_fill,
              iconColor: Colors.blue,
              title: 'Change Password',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => ForgotPasswordScreen()),
              ),
            )),
        const SizedBox(height: 16),
        BuildGradientCard(
            title: 'Help & Info',
            icon: CupertinoIcons.info_circle,
            color: Colors.teal,
            child: Column(
              children: [
                buildSettingsTile(
                  icon: CupertinoIcons.doc_text_fill,
                  iconColor: Colors.purple,
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const PrivacyPolicy()));
                  },
                ),
                buildSettingsTile(
                  icon: CupertinoIcons.mail_solid,
                  iconColor: Colors.green,
                  title: 'Contact Us',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const ContactUs()));
                  },
                ),
                buildSettingsTile(
                  icon: CupertinoIcons.info_circle_fill,
                  iconColor: Colors.blue,
                  title: 'About',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => AboutPage()));
                  },
                ),
                buildSettingsTile(
                  icon: CupertinoIcons.doc_plaintext,
                  iconColor: Colors.indigo,
                  title: 'Terms & Conditions',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => TermsAndCondition()));
                  },
                  showBorder: false,
                ),
              ],
            )),
      ],
    );
  }
}
