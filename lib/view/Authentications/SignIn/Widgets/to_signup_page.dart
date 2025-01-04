import 'package:flutter/material.dart';

import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/sign_up.dart';

class ToSignUpPage extends StatelessWidget {
  const ToSignUpPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(color: secondaryTextColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (ctx)=>SignupScreen()));
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
