import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/model/session_model.dart';

class SessionProvider extends ChangeNotifier {
  List<SessionModel> _sessions = [];
  bool _isLoading = false;
  String? _error;

  List<SessionModel> get sessions => _sessions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSessions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final teamId = await UserDatabase().getTeamId();
      final snapshot = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .collection('sessions')
          .get();

      _sessions = snapshot.docs.map((doc) {
        return SessionModel(
          name: doc['name'],
          description: doc['description'],
          sessionType: doc['sessionType'],
          date: doc['date'],
          imagePath: doc['imagePath'],
          location: doc['location'],
        );
      }).toList();
    } catch (e) {
      _error = "Failed to load sessions";
    }

    _isLoading = false;
    notifyListeners();
  }
}
