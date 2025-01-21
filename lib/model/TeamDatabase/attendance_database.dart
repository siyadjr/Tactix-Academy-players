import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';

class AttendanceDatabase {
  Future<Map<String, dynamic>> getAttendance() async {
    final teamId = await UserDatabase().getTeamId();
    final date = DateTime.now();
    final selectedDate = "${date.day}/${date.month}/${date.year}";

    String formattedDate = selectedDate.replaceAll('/', '');
    log(formattedDate);

    if (teamId != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('Teams')
            .doc(teamId)
            .collection('Attendance')
            .doc(formattedDate)
            .get();
        final data = snapshot.data();
        if (data != null) {
          log('$data');
          return data;
        } else {
          log("No data found for this date.");
          return <String, dynamic>{};
        }
      } catch (e) {
        log("Error fetching attendance: $e");
        return <String, dynamic>{};
      }
    } else {
      log("Team ID is not available.");
      return <String, dynamic>{};
    }
  }

  Future<void> punchAttendance() async {
    final date = DateTime.now();
    final selectedDate = "${date.day}/${date.month}/${date.year}";
    final user = FirebaseAuth.instance.currentUser;

    String formattedDate = selectedDate.replaceAll('/', '');
    final teamId = await UserDatabase().getTeamId();

    if (user != null && teamId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Teams')
            .doc(teamId)
            .collection('Attendance')
            .doc(formattedDate)
            .update({
          'attendedPlayers':
              FieldValue.arrayUnion([user.uid]), // Add user ID to array
        });
        print('Attendance punched successfully.');
      } catch (e) {
        print('Error punching attendance: $e');
      }
    } else {
      print('User or teamId is null.');
    }
  }
  Future<List<Map<String, dynamic>>> getAllAttendance() async {
  final teamId = await UserDatabase().getTeamId();
  
  if (teamId == null) {
    log("Team ID is not available.");
    return [];
  }

  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Teams')
        .doc(teamId)
        .collection('Attendance')
        .get();

    // Extracting documents into a list of maps
    final data = snapshot.docs.map((doc) => doc.data()).toList();

    if (data.isNotEmpty) {
      log('Attendance Data: $data');
      return data;
    } else {
      log("No attendance data found.");
      return [];
    }
  } catch (e) {
    log("Error fetching attendance: $e");
    return [];
  }
}
}
