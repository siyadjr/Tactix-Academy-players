import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';

class ScreenHomeController extends ChangeNotifier {
  String _teamName = "Loading...";
  String _teamPhotoUrl = "";
  String _managerPhotoUrl = "";
  List<String> _playersPhotos = [];
  String get teamName => _teamName;
  String get teamPhotoUrl => _teamPhotoUrl;
  String get managerPhotoUrl => _managerPhotoUrl;
  List<String> get playersPhotos => _playersPhotos;

  Future<void> fetchTeamNameAndPhoto() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        _teamName = "No User Logged In";
        _teamPhotoUrl = "";
        _managerPhotoUrl = "assets/default_team_logo.png";
        notifyListeners();
        return;
      }

      // Fetch user document from 'Players' collection
      final userDoc = await FirebaseFirestore.instance
          .collection('Players')
          .doc(user.uid)
          .get();

      if (!userDoc.exists || userDoc.data() == null) {
        _teamName = "Player Document Not Found";
        _teamPhotoUrl = "";
        _managerPhotoUrl = "assets/default_team_logo.png";
        notifyListeners();
        return;
      }

      final teamId = userDoc.data()?['teamId'];
      final playerName = userDoc.data()?['name'];

      if (teamId == null) {
        _teamName = "No Team Assigned";
        _teamPhotoUrl = "";
        _managerPhotoUrl = "assets/default_team_logo.png";
        notifyListeners();
        return;
      }

      // Fetch the team document using the teamId
      final teamDoc = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .get();
      fetchPlayersPhotos();

      if (teamDoc.exists && teamDoc.data() != null) {
        _teamName = teamDoc.data()?['teamName'] ?? "Unnamed Team";
        _teamPhotoUrl = teamDoc.data()?['teamPhoto'] ?? "";
        // log(_teamName);
        // log('Fetched team photo URL: $_teamPhotoUrl');
      } else {
        _teamName = "Team Not Found";
        _teamPhotoUrl = "";
      }

      _managerPhotoUrl =
          teamDoc.data()?['managerPhoto'] ?? "assets/default_team_logo.png";
    } catch (e) {
      _teamName = "Error Loading Team Data";
      _teamPhotoUrl = "";
      _managerPhotoUrl = "assets/default_team_logo.png";

      log("Error fetching team and player details: $e");
    }

    notifyListeners();
  }

  Future<void> fetchPlayersPhotos() async {
    try {
      // Step 1: Fetch the team document
      log('callled');
      final teamId = await UserDatabase().getTeamId();
      final teamSnapshot = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .get();

      // Ensure the team document exists
      if (teamSnapshot.exists) {
        final teamData = teamSnapshot.data();
        if (teamData != null) {
          // Step 2: Retrieve the list of player IDs from the team document
          final List<dynamic> playerIds = teamData['players'] ?? [];

          if (playerIds.isNotEmpty) {
            // Step 3: Fetch player details from the 'Players' collection
            final playersQuery = await FirebaseFirestore.instance
                .collection('Players')
                .where(FieldPath.documentId, whereIn: playerIds)
                .get();

            // Step 4: Process the player data
            final players = playersQuery.docs.map((doc) => doc.data()).toList();
            _playersPhotos.clear();
            _playersPhotos
                .addAll(players.map((player) => player['userProfile']));
          } else {
            // print('No players found for this team.');
          }
        } else {
          print('Team data is null.');
        }
      } else {
        print('Team document does not exist.');
      }
    } catch (e) {
      print('Error fetching players: $e');
    }
  }
}
