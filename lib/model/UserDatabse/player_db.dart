import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/model/playermodel.dart';

class PlayerDataBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlayerModel>> fetchTeamPlayers() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      QuerySnapshot querySnapshot = await _firestore
          .collection('Players')
          .where('teamId', isEqualTo: teamId)
          .get();

      return querySnapshot.docs.map((doc) {
        return PlayerModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error fetching players: $e');
      return [];
    }
  }
}
