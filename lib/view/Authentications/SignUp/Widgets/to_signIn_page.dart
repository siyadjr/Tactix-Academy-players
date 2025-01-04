import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Authentications/SignIn/sign_in.dart';

class ToSignInpage extends StatelessWidget {
  const ToSignInpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: secondaryTextColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => const SignIn()),
              (route) => true,
            );
          },
          child: const Text(
            'Sign In',
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
