import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_players/model/playermodel.dart';

class PlayerDataBase {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlayerModel>> fetchTeamPlayers() async {
    try {
      // Fetch players from the 'Players' collection
      QuerySnapshot querySnapshot = await _firestore.collection('Players').get();

      // Map Firestore documents to PlayerModel objects
      return querySnapshot.docs.map((doc) {
        return PlayerModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching players: $e');
      return [];
    }
  }
  
}
