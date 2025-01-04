import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/core/Theme/button_styles.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/view/Authentications/SignIn/Widgets/to_signup_page.dart';
import 'package:tactix_academy_players/view/Authentications/SignIn/forgot_password.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/Widgets/or_sign_with_google.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/Widgets/sign_in_widget.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back !!',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SignInWidget(
                    nameController: nameController,
                    formKey: _formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ForgotPasswordScreen()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await UserDatabase().signInWithEmailPassword(
                          context,
                          emailController,
                          passwordController,
                          nameController,
                        );
                      }
                    },
                    style: elevatedButtonStyle,
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: secondaryTextColor),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const OrSignWIthGoogle(),
                  const SizedBox(height: 10.0),
                  IconButton(
                    onPressed: () {
                      UserDatabase().signWithGoogle(context);
                    },
                    icon: Brand(Brands.google),
                    iconSize: 40.0,
                  ),
                  const SizedBox(height: 20.0),
                  const ToSignUpPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
