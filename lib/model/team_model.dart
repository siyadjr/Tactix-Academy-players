import 'package:tactix_academy_players/model/manager_model.dart';

class TeamModel {
  String teamName;
  String teamPhoto;
  String teamLocation;
  ManagerModel teamManager;
  int teamPlayersCount;
  TeamModel(
      {required this.teamName,
      required this.teamManager,
      required this.teamLocation,
      required this.teamPhoto,
      required this.teamPlayersCount});
}
