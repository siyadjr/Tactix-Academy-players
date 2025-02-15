import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Important/shared_preference.dart';
import 'package:tactix_academy_players/model/TeamDatabase/team_database.dart';
import 'package:tactix_academy_players/model/team_model.dart';
import 'package:tactix_academy_players/view/Teams/Screens/join_teams.dart';

class TeamProfileProvider extends ChangeNotifier {
  bool _isloading = false;

  bool get isLoading => _isloading;
  TeamModel? _team;
  TeamModel? get team => _team;
  Future<void> getTeamDetails() async {
    _isloading = true;
    notifyListeners();
    _team = await TeamDatabase().getTeamDetails();
    if (_team != null) {
      if (_team!.teamManager != null) {
        log(_team!.teamManager.name);
      }
    }
    _isloading = false;
    notifyListeners();
  }



Future<void> leftFromTeam(context) async {
 try {
   _isloading = true;
   notifyListeners();
   await TeamDatabase().leftTeam();
   SharedPreferenceDatas().sharedPrefLeftTeam();
   _isloading = false;
   notifyListeners();
   Navigator.pushAndRemoveUntil(context,
       MaterialPageRoute(builder: (ctx) => JoinTeams()), (_) => false);
 } catch (e) {
   _isloading = false;
   notifyListeners();
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text('Failed to leave team: $e')),
   );
 }
}

}
