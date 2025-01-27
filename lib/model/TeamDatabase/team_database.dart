import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/model/manager_model.dart';

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

        // Convert Firestore data into a ManagerModel object
        return ManagerModel(
          id: snapshot.docs.first.id,
          name: data['name'],
          userProfile: data['userProfile'], // Assuming this field exists
          licenseUrl: data['licenseUrl'], // Assuming this field exists
          teamId: teamId,
        );
      }

      return null; // Return null if no manager is found
    } catch (e) {
      print('Error fetching manager: $e');
      return null;
    }
  }
}
