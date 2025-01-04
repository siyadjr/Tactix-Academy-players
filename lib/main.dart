import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tactix_academy_players/controller/screen_home_controller.dart';
import 'package:tactix_academy_players/controller/team_controller.dart';
import 'package:tactix_academy_players/firebase_options.dart';
import 'package:tactix_academy_players/view/Authentications/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 runApp(const MyApp());
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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
