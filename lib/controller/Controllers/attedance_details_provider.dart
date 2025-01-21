import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tactix_academy_players/model/TeamDatabase/attendance_database.dart';

class AttendanceDetailsProvider extends ChangeNotifier {
  List<String> _attendedDates = [];
  List<String> _absentDates = [];
  bool _isLoading = false;

  List<String> get attendedDates => _attendedDates;
  List<String> get absentDates => _absentDates;
  bool get isLoading => _isLoading;

  Future<void> fetchAllAttendance() async {
    _isLoading = true;
    notifyListeners();

    final today = DateTime.now();

    final List<Map<String, dynamic>> allAttendance =
        await AttendanceDatabase().getAllAttendance();

    _attendedDates.clear();
    _absentDates.clear();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      log("User not logged in");
      _isLoading = false;
      notifyListeners();
      return;
    }

    for (var record in allAttendance) {
      log(record.toString());

      if (!record.containsKey('date')) continue;

      final recordDateString = record['date'];
      try {
        DateTime recordDate = DateFormat('d/M/yyyy').parse(recordDateString);
        log('Parsed Date: $recordDate');

        if (!recordDate.isAfter(today)) {
          if (record.containsKey('attendedPlayers') &&
              record['attendedPlayers'] is List) {
            if (record['attendedPlayers'].contains(userId)) {
              _attendedDates.add(recordDateString);
            } else {
              _absentDates.add(recordDateString);
            }
          }
        }
      } catch (e) {
        log("Error parsing date: $recordDateString - $e");
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
