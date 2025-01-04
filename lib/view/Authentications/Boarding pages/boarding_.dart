import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Authentications/SignIn/sign_in.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/sign_up.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      pageColor: mainBackground,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white70,
        height: 1.5, // Line height for better readability
      ),
      titlePadding: EdgeInsets.only(top: 20.0), // Top spacing for the title
      bodyPadding: EdgeInsets.symmetric(
          horizontal: 24.0), // Horizontal padding for the body text
      contentMargin:
          EdgeInsets.symmetric(horizontal: 16.0), // Overall content margin
      imagePadding: EdgeInsets.only(
          top: 40.0, bottom: 20.0), // Space between image and text
    );
    return Scaffold(
      backgroundColor: mainBackground,
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            decoration: pageDecoration,
            title: "Welcome to Tactix Academy",
            body: "Learn, train, and master football tactics.",
            image: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.3, // Responsive height
                child: Image.asset('assets/image.jpg', fit: BoxFit.contain),
              ),
            ),
          ),
          PageViewModel(
            decoration: pageDecoration,
            title: "Create Your Team",
            body: "Build and manage your own team of talented players.",
            image: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/image.jpg', fit: BoxFit.contain),
              ),
            ),
          ),
          PageViewModel(
            decoration: pageDecoration,
            title: "Track Your Progress",
            body: "Monitor performance and achieve your football goals.",
            image: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/image.jpg', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => SignIn()));
        },
        onSkip: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => SignIn()));
        },
        showSkipButton: true,
        globalBackgroundColor: mainBackground,
        skip: const Text("Skip", style: TextStyle(color: Colors.blue)),
        next: const Icon(Icons.arrow_forward, color: Colors.blue),
        done: const Text("Get Started",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
        dotsDecorator: DotsDecorator(
          activeColor: Colors.blue,
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}
