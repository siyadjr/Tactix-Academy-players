import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tactix_academy_players/core/Important/shared_preference.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Authentications/SignIn/sign_in.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/sign_up.dart';
import 'package:tactix_academy_players/view/BottomNavigation/bottom_navigation_bar.dart';

import 'package:tactix_academy_players/view/Teams/Screens/join_teams.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => SignupScreen()));
      checkLogin(context);
    });
    return Scaffold(
      backgroundColor: mainBackground,
      body: Center(
        child: SizedBox(
            height: 240, child: Image.asset('assets/Tactix app logo.jpg')),
      ),
    );
  }

  Future<void> checkLogin(BuildContext context) async {
    final sharepref = await SharedPreferences.getInstance();

    final signUp = sharepref.getBool(userRegisterd);
    final loggin = sharepref.getBool(userLoggedIn);
    if (signUp != null && signUp == true) {
      if (loggin != null && loggin == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => CustomBottomNavigationBar()),
            (_) => false);
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (ctx) => JoinTeams()), (_) => false);
      }
    } else if (loggin != null && loggin == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (ctx) => const CustomBottomNavigationBar()),
          (_) => false);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (ctx) => const SignIn()), (_) => false);
    }
  }
}
