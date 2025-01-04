import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/core/Theme/button_styles.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/Widgets/or_sign_with_google.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/Widgets/sign_in_widget.dart';
import 'package:tactix_academy_players/view/Authentications/SignUp/Widgets/to_signIn_page.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return CustomScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Get Started !!',
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
                const SizedBox(height: 20.0),
                ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, loading, child) {
                    return loading
                        ? GestureDetector(
                            onTap: () {
                              isLoading.value = false;
                            },
                            child: const CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                isLoading.value = true;
                                log('${nameController.text}>>>>>${passwordController.text}');
                                await UserDatabase().signUpWithEmailPassword(
                                  context,
                                  nameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  '',
                                );
                                isLoading.value = false;
                              }
                            },
                            style: elevatedButtonStyle,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: secondaryTextColor),
                            ),
                          );
                  },
                ),
                const SizedBox(height: 20.0),
                const OrSignWIthGoogle(),
                const SizedBox(height: 10.0),
                IconButton(
                  onPressed: () async {
                    isLoading.value = true;
                    await UserDatabase().signupWithGoogle(context);
                    isLoading.value = false;
                  },
                  icon: Brand(Brands.google),
                  iconSize: 40.0,
                ),
                const SizedBox(height: 20.0),
                const ToSignInpage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
