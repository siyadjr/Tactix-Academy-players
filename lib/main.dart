import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/Controllers/attedance_details_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/attendance_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/bottom_navigation_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/chat_hub_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/payment_details_controller.dart';
import 'package:tactix_academy_players/controller/Controllers/payment_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/player_details_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/players_status_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/screen_home_controller.dart';
import 'package:tactix_academy_players/controller/Controllers/session_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/tactix_ai_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/team_controller.dart';
import 'package:tactix_academy_players/controller/Controllers/team_profile_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/team_status_provider.dart';
import 'package:tactix_academy_players/controller/Controllers/user_profile_provider.dart';
import 'package:tactix_academy_players/core/Important/gemini_ai.dart';
import 'package:tactix_academy_players/core/Important/stripe.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/firebase_options.dart';
import 'package:tactix_academy_players/view/Authentications/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: GEMINI_API_KEY);
  await _setUp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

Future<void> _setUp() async {
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TeamProviderController()..fetchTeams(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScreenHomeController()..fetchTeamNameAndPhoto(),
        ),
        ChangeNotifierProvider(
          create: (_) => AttendanceProvider(),
        ),
        ChangeNotifierProvider(create: (_) => AttendanceDetailsProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => TeamStatusProvider()),
        ChangeNotifierProvider(create: (_) => TactixAiProvider()),
        ChangeNotifierProvider(create: (_) => ChatHubProvider()),
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => PaymentDetailsController()),
        ChangeNotifierProvider(create: (_) => PlayerDetailsProvider()),
        ChangeNotifierProvider(create: (_) => PlayersStatusProvider()),
        ChangeNotifierProvider(create: (_) => TeamProfileProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider())
      ],
      child: MaterialApp(
        theme: themdata,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
