import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tactix_academy_players/core/Important/cloudinery_class.dart';
import 'package:tactix_academy_players/core/Important/shared_preference.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Home/screen_home.dart';
import 'package:tactix_academy_players/view/Teams/Screens/join_teams.dart';

class UserDatabase {
  Future<void> signUpWithEmailPassword(BuildContext context, String name,
      String email, String password, String teamId) async {
    try {
      // Check if email exists in Managers collection
      final managerDoc = await FirebaseFirestore.instance
          .collection('Managers')
          .where('email', isEqualTo: email)
          .get();

      if (managerDoc.docs.isNotEmpty) {
        log("User exists in Managers. Redirecting to home screen.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const ScreenHome()),
        );
        return;
      }

      // Create user with email and password
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('Players')
            .doc(user.uid)
            .set({
          'name': name.isNotEmpty ? name : 'Unknown',
          'email': email,
          'teamId': teamId.isNotEmpty ? teamId : 'Not Assigned',
          'userProfile':
              'https://res.cloudinary.com/dplpu9uc5/image/upload/v1734508378/Default_avatar_uznlbr.jpg',
          'number': '0',
          'achivements': [],
          'matches': '0',
          'fit': 'Fit',
          'goals': '0',
          'assists': '0',
          'rank': '0',
          'position': 'Unknown'
        });

        log("User data stored successfully in Firestore");

        // Navigate to the next screen
        SharedPreferenceDatas().sharedPrefSignup();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => JoinTeams()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log("Email already in use.");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email already in use."),
          backgroundColor: mainBackground,
        ));
      } else if (e.code == 'weak-password') {
        log("Weak password.");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The password provided is too weak."),
          backgroundColor: Colors.red,
        ));
      } else {
        log("FirebaseAuthException: ${e.message}");
        showSnackBar(context, "An error occurred. Please try again.");
      }
    } catch (e) {
      log("Error during sign-up: $e");
      showSnackBar(context, "Unexpected error occurred. Please try again.");
    }
  }

  Future<void> signupWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log("Google sign-in canceled by user.");
        return;
      }

      log("Google User Info: ${googleUser.displayName}, ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // Check if the user exists in Managers collection
        final managerDoc = await FirebaseFirestore.instance
            .collection('Managers')
            .where('email', isEqualTo: user.email)
            .get();

        if (managerDoc.docs.isNotEmpty) {
          log("User exists in Managers. Redirecting to home screen.");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => const ScreenHome()),
          );
          return;
        }

        final photo = await CloudineryClass().uploadProfile(user.photoURL!);
        await FirebaseFirestore.instance
            .collection('Players')
            .doc(user.uid)
            .set({
          'name': user.displayName ?? 'Google User',
          'email': user.email,
          'password': user.photoURL,
          'userProfile': photo,
          'matches': '0',
          'teamId': 'Not Assigned',
          'number': '0',
          'fit': 'Fit',
          'achivements': [],
          'goals': '0',
          'assists': '0',
          'rank': '0',
          'position': 'Unknown'
        });

        SharedPreferenceDatas().sharedPrefSignup();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => JoinTeams()),
        );

        log("Google sign-in successful, data stored in Firestore.");
      } else {
        log("No Firebase user found after Google sign-in.");
      }
    } catch (e) {
      log("Error during Google Sign-In: $e");
    }
  }

  Future<void> signWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log("Google sign-in canceled by user.");
        return;
      }
      log("Google User Info: ${googleUser.displayName}, ${googleUser.email}");

      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // Check if the user exists in Managers collection
        final managerDoc = await FirebaseFirestore.instance
            .collection('Managers')
            .where('email', isEqualTo: user.email)
            .get();

        if (managerDoc.docs.isNotEmpty) {
          log("User exists in Managers. Redirecting to home screen.");
          SharedPreferenceDatas().sharedPrefSignIn();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ScreenHome()),
          );
        } else {
          log("User not found in Managers. Showing SnackBar.");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No manager account found with this email."),
            backgroundColor: mainBackground,
          ));
        }
      } else {
        log("No Firebase user found.");
      }
    } catch (e) {
      log("Error during Google Sign-In: $e");
    }
  }

  Future<void> uploadLicense(String imagePath) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("No authenticated user found.");
      }

      await FirebaseFirestore.instance
          .collection('Players')
          .doc(user.uid)
          .update({'licenseUrl': imagePath, 'license status': 'pending'});

      log("License uploaded successfully.");
    } catch (e) {
      log("Error uploading license: $e");
    }
  }

  Future<void> signInWithEmailPassword(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController nameController) async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Players')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        // No user found with the given email
        log("No user found for the given email.");
        showSnackBar(context, "No user found for this email.");
        return;
      }

      final userDoc = snapshot.docs.first;
      final userData = userDoc.data() as Map<String, dynamic>;

      // Check if the name matches (optional, if required)
      if (userData['name'] == name) {
        log("Sign-in successful. Navigating to HomeScreen.");
        SharedPreferenceDatas().sharedPrefSignIn();
        // // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenHome()),
        );
      } else {
        log("Invalid name.");
        showSnackBar(context, "Incorrect name.");
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Authentication errors
      if (e.code == 'user-not-found') {
        log("No user found for the given email.");
        showSnackBar(context, "No user found for this email.");
      } else if (e.code == 'wrong-password') {
        log("Incorrect password.");
        showSnackBar(context, "Incorrect password.");
      } else {
        log("Error during sign-in: $e");
        showSnackBar(context, "An error occurred. Please try again.");
      }
    } catch (e) {
      // Catch any other errors
      log("Error during sign-in: $e");
      showSnackBar(context, "An error occurred. Please try again.");
    }
  } //>>>>>>>>>>>>>>>>>>>>>>>>>>>>fetch teamId>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<String> getTeamId() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;

      // Fetch user data from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection(
              'Players') // Replace 'Players' with your users' collection
          .doc(userId)
          .get();

      // Ensure teamId is returned if available
      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        if (data.containsKey('teamId')) {
          return data['teamId'] as String;
        }
      }
    }

    // Throw an error or return a default value if user or teamId is not found
    throw Exception('Team ID not found');
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>join request >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future<void> requestToJoinTeam(BuildContext context, String teamId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userId = user.uid;

        // Fetch user data from Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection(
                'Players') // Replace 'Players' with your users' collection
            .doc(userId)
            .get();

        final userName = userDoc['name'];

        final teamDoc =
            FirebaseFirestore.instance.collection('Teams').doc(teamId);

        await teamDoc.update({
          'playersRequests': FieldValue.arrayUnion([
            {
              'userId': userId,
            },
          ]),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending request: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: mainBackground,
      ),
    );
  }
}
