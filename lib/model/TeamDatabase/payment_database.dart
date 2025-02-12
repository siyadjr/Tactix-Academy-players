import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tactix_academy_players/model/TeamDatabase/team_database.dart';
import 'package:tactix_academy_players/model/UserDatabse/user_database.dart';
import 'package:tactix_academy_players/model/payment_model.dart';

class PaymentDatabase {
  Future<bool> checkPaymentStatus() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      if (teamId == null) return false;

      final snapShot = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .get();

      return snapShot.exists && (snapShot.data()?['rentEnabled'] ?? false);
    } catch (e) {
      log('Error checking payment status: $e');
      return false;
    }
  }

  Future<String?> getRentFee() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      if (teamId == null) return null;

      final snapShot = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .get();

      return snapShot.data()?['rentFee'];
    } catch (e) {
      log('Error getting rent fee: $e');
      return null;
    }
  }

  Future<bool> isPlayerPaid() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (teamId == null) return false;

      final now = DateTime.now();
      final todaysMonthAndYear = '${now.month}-${now.year}';

      final snapShot = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .collection('Payments')
          .doc(todaysMonthAndYear)
          .collection('PaidPlayers')
          .doc(userId)
          .get();

      return snapShot.exists;
    } catch (e) {
      log('Error checking if player paid: $e');
      return false;
    }
  }

  Future<void> payRent(String rentFee) async {
    try {
      final teamId = await UserDatabase().getTeamId();
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (teamId == null) return;

      final now = DateTime.now();
      final currentMonth = now.month;
      final currentYear = now.year;
      final todaysMonthAndYear = '$currentMonth-$currentYear';

      final paymentData = {
        'userId': userId,
        'amount': rentFee,
        'paidDate': now.toIso8601String(),
        'month': currentMonth,
        'year': currentYear,
      };

      final paymentRef = FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .collection('Payments')
          .doc(todaysMonthAndYear);

      await paymentRef.collection('PaidPlayers').doc(userId).set(paymentData);

      await paymentRef.set(
          {'paymentMonth': currentMonth, 'paymentYear': currentYear},
          SetOptions(merge: true));

      log('Payment record added for $todaysMonthAndYear: $paymentData');
    } catch (e) {
      log('Error in payRent: $e');
    }
  }

  Future<List<String>> getPlayerAllPayments() async {
    try {
      final teamId = await UserDatabase().getTeamId();
      if (teamId == null) return [];

      final snapShot = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .collection('Payments')
          .get();

      return snapShot.docs.map((doc) {
        final data = doc.data();
        return doc.id;
      }).toList();
    } catch (e) {
      log('Error fetching player payments: $e');
      return [];
    }
  }

  Future<PaymentModel?> checkPaidOrNot(String id) async {
    try {
      final teamId = await UserDatabase().getTeamId();
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (teamId == null) return null;

      final docRef = await FirebaseFirestore.instance
          .collection('Teams')
          .doc(teamId)
          .collection('Payments')
          .doc(id)
          .collection('PaidPlayers')
          .doc(userId)
          .get();

      if (docRef.exists) {
        final data = docRef.data()!;
        return PaymentModel(
          name: id,
          date: data['paidDate'],
          amount: data['amount'],
        );
      }
      return null;
    } catch (e) {
      log('Error checking if user has paid: $e');
      return null;
    }
  }
}
