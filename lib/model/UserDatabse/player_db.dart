import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';

import '../playermodel.dart';

class PlayerDataBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlayerModel>> fetchTeamPlayers() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      if (teamId == null) throw Exception('Team ID not found');

      QuerySnapshot querySnapshot = await _firestore
          .collection('Players')
          .where('teamId', isEqualTo: teamId)
          .get();

      return querySnapshot.docs.map((doc) {
        return PlayerModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch players: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAchievementsByPlayer(
      String playerId) async {
    try {
      final docSnapshot =
          await _firestore.collection('Players').doc(playerId).get();

      if (!docSnapshot.exists) {
        return [];
      }

      final data = docSnapshot.data();
      if (data == null || !data.containsKey('achivements')) {
        log('didnt got');
        return [];
      }

      return List<Map<String, dynamic>>.from(data['achivements']);
    } catch (e) {
      throw Exception('Failed to fetch achievements: $e');
    }
  }

  Future<PlayerModel?> getUser() async {
  try {
    final playerId = FirebaseAuth.instance.currentUser?.uid;
    if (playerId == null) return null;

    final teamId = await UserDatabase().getTeamId();
    if (teamId == null) return null;

    final snapshot = await _firestore.collection('Players').doc(playerId).get();

    if (snapshot.exists && snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;

      return PlayerModel(
        id: snapshot.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        userProfile: data['userProfile'] ?? '',
        number: data['number'] ?? '0',
        position: data['position'] ?? '',
        fit: data['fit'] ?? '',
        teamId: teamId,
        goals: data['goals'] ?? '0',
        assists: data['assists'] ?? '0',
        matches: data['matches'] ?? '0',
      );
    } else {
      return null;
    }
  } catch (e) {
    log('Failed to get user: $e');
    return null;
  }
}

}
