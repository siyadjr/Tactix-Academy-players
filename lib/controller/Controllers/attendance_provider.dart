import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/TeamDatabase/attendance_database.dart';
import 'dart:async';

class AttendanceProvider extends ChangeNotifier {
  Map<String, dynamic> _todaysAttendance = {};
  bool _isLoading = false;
  bool _punched = false;
  bool _isTimeOver = false;
  bool get isTimeOver => _isTimeOver;
  String _remainingTime = '00:00:00';
  late Timer _timer;

  bool get isLoading => _isLoading;
  bool get punched => _punched;
  String get remainingTime => _remainingTime;
  Map<String, dynamic> get todaysAttendance => _todaysAttendance;

  Future<void> fetchAttendance() async {
    _isLoading = true;
    _punched = false;
    notifyListeners();

    try {
      _todaysAttendance = await AttendanceDatabase().getAttendance();
      final userID = FirebaseAuth.instance.currentUser?.uid;
      _isTimeOver = false;
      if (_todaysAttendance['attendedPlayers'] != null &&
          _todaysAttendance['attendedPlayers'].contains(userID)) {
        _punched = true;
      } else {
        _punched = false;
      }

      // Start the countdown timer if it's an attendance day
      if (_todaysAttendance['time'] != null) {
        startCountdown();
      }
    } catch (e) {
      _todaysAttendance = {};
      _punched = false;
    } finally {
      Future.delayed(const Duration(milliseconds: 40), () {
        _isLoading = false;
      });

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> punchAttendance() async {
    await AttendanceDatabase().punchAttendance();
    _punched = true;
    fetchAttendance(); // Refresh attendance after punching
  }

  // Start countdown timer based on the target time
  void startCountdown() {
    final timeString = _todaysAttendance['time'];
    final timeParts = timeString.split(':');
    final targetHour = int.parse(timeParts[0]);
    final targetMinute = int.parse(timeParts[1]);

    final now = DateTime.now();
    final targetTime =
        DateTime(now.year, now.month, now.day, targetHour, targetMinute);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final duration = targetTime.difference(DateTime.now());

      if (duration.isNegative) {
        _remainingTime = 'Time has passed';
        _isTimeOver = true;
        _timer.cancel(); // Stop the timer once time has passed
      } else {
        final hours = duration.inHours;
        final minutes = duration.inMinutes % 60;
        final seconds = duration.inSeconds % 60;
        _remainingTime = '$hours:$minutes:$seconds';
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
