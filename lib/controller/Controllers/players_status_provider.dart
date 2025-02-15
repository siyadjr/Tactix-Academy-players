import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/UserDatabse/player_db.dart';
import 'package:tactix_academy_players/model/playermodel.dart';

class PlayersStatusProvider extends ChangeNotifier {
  List<PlayerModel> _topScorers = [];
  List<PlayerModel> get topScorers => _topScorers;
  List<PlayerModel> _assisters = [];
  List<PlayerModel> get assisters => _assisters;
  List<PlayerModel> _ratedPlayers = [];
  List<PlayerModel> get ratedPlayers => _ratedPlayers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getTopScorers() async {
    _isLoading = true;
    notifyListeners();

    _topScorers = await PlayerDataBase().fetchTeamPlayers();

    _topScorers.sort((a, b) {
      int goalsA = int.tryParse(a.goals) ?? 0;
      int goalsB = int.tryParse(b.goals) ?? 0;
      return goalsB.compareTo(goalsA); // Sort in descending order
    });

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAssisters() async {
    _isLoading = true;
    notifyListeners();

    _assisters = await PlayerDataBase().fetchTeamPlayers();

    _assisters.sort((a, b) {
      int goalsA = int.tryParse(a.assists) ?? 0;
      int goalsB = int.tryParse(b.assists) ?? 0;
      return goalsB.compareTo(goalsA); // Sort in descending order
    });

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getRanking() async {
  _isLoading = true;
  notifyListeners();

  _ratedPlayers = await PlayerDataBase().fetchTeamPlayers();

  _ratedPlayers.sort((a, b) {
    int matchesA = int.tryParse(a.matches) ?? 0;
    int matchesB = int.tryParse(b.matches) ?? 0;
    int goalsA = int.tryParse(a.goals) ?? 0;
    int goalsB = int.tryParse(b.goals) ?? 0;
    int assistsA = int.tryParse(a.assists) ?? 0;
    int assistsB = int.tryParse(b.assists) ?? 0;

    // Calculate ratio, handling 0 matches correctly
    double ratioA = (matchesA == 0) ? (goalsA + assistsA) * 1.5 : (goalsA + assistsA) / matchesA;
    double ratioB = (matchesB == 0) ? (goalsB + assistsB) * 1.5 : (goalsB + assistsB) / matchesB;

    return ratioB.compareTo(ratioA); // Sort in descending order
  });

  _isLoading = false;
  notifyListeners();
}

}
