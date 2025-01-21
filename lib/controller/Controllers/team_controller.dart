import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeamProviderController extends ChangeNotifier {
  List<Map<String, dynamic>> _teams = [];
  List<Map<String, dynamic>> filteredTeams = [];

  List<Map<String, dynamic>> get teams => _teams;

  TeamProviderController() {
    fetchTeams(); // Automatically fetch teams on initialization
  }

  Future<void> fetchTeams() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Teams').get();
      log(snapshot.toString());

      _teams = snapshot.docs.map((doc) {
        return {
          'teamId': doc.id,
          'teamName': doc['teamName'] ?? 'Unknown Team',
          'managerId': doc['managerId'] ?? '',
          'teamLocation': doc['teamLocation'] ?? '',
        };
      }).toList();

      filteredTeams = List.from(_teams);
      notifyListeners();
    } catch (e) {
      log('Error fetching teams: $e');
    }
  }

  void filterTeams(String query) {
    if (query.isEmpty) {
      filteredTeams = List.from(_teams); // Reset to all teams
    } else {
      filteredTeams = _teams.where((team) {
        return team['teamName']!
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
