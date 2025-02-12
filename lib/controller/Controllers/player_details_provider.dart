import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/UserDatabse/player_db.dart';
import 'package:tactix_academy_players/model/playermodel.dart';

class PlayerDetailsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _achievements = [];
  List<Map<String, dynamic>> get achievements => _achievements;
  String? _error;

  String? get error => _error;
  List<PlayerModel> _allPlayers = [];
  List<PlayerModel> get allPlayers => _allPlayers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getAllPlayers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allPlayers = await PlayerDataBase().fetchTeamPlayers();
      for (var player in _allPlayers) {
        log(player.name);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 
  Future<void> getAchievement(String playerId) async {
    if (_isLoading) return; // Prevent multiple simultaneous loads
    
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newAchievements = await PlayerDataBase().getAchievementsByPlayer(playerId);
      _achievements = newAchievements;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
