import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/model/manager_model.dart';
import 'package:tactix_academy_players/model/team_model.dart';

class TeamDatabase {
  Future<ManagerModel?> fetchTeamManager() async {
    try {
      final teamId = await UserDatabase().getTeamId();

      final snapshot = await FirebaseFirestore.instance
          .collection('Managers')
          .where('teamId', isEqualTo: teamId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data(); // Get the first document
        return ManagerModel(
          id: snapshot.docs.first.id,
          name: data['name'],
          userProfile: data['userProfile'],
          licenseUrl: data['licenseUrl'],
          teamId: teamId,
        );
      }
      return null;
    } catch (e) {
      print('Error fetching manager: $e');
      return null;
    }
  }

  Future<TeamModel?> getTeamDetails() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      final manager = await fetchTeamManager();

      final snapShot = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .get();

      if (snapShot.exists) {
        final teamData = TeamModel(
          teamName: snapShot.data()?['teamName'],
          teamManager: manager ??
              ManagerModel(
                  id: '',
                  name: 'Unknown',
                  userProfile: '',
                  licenseUrl: '',
                  teamId: teamId),
          teamLocation: snapShot.data()?['teamLocation'],
          teamPhoto: snapShot.data()?['teamPhoto'],
          teamPlayersCount:
              (snapShot.data()?['players'] as List<dynamic>).length,
        );
        return teamData;
      } else {
        print('No team data found for teamId: $teamId');
        return null; // Missing return added here
      }
    } catch (e) {
      print('Error fetching team details: $e');
      return null; // Missing return added here
    }
  }

  Future<void> leftTeam() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      final userId = FirebaseAuth.instance.currentUser;
      final playerId = userId?.uid ?? '';
      if (playerId.isNotEmpty && teamId.isNotEmpty) {
        DocumentReference teamRef =
            FirebaseFirestore.instance.collection('Teams').doc(teamId);

        await teamRef.update({
          'players': FieldValue.arrayRemove([playerId])
        });
        await FirebaseFirestore.instance
            .collection('Players')
            .doc(playerId)
            .update({'teamId': FieldValue.delete()});
      }
    } catch (e) {
      print('Error leaving team: $e');
      throw e;
    }
  }
}
