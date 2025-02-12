import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/TeamDatabase/payment_database.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  bool _isActive = false;
  bool get isActive => _isActive;
  String? _rentFee;
  String? get rentFee => _rentFee;
  bool _isPaid = false;
  bool get isPaid => _isPaid;

  Future<void> checkRentStatus() async {
    _isloading = true;
    notifyListeners();
    final value = await PaymentDatabase().checkPaymentStatus();
    if (value != null) {
      _isActive = value;
      if (_isActive == true) {
        getRentFee();
        isPlayerPaid();
      }
    }
    _isloading = false;
    notifyListeners();
  }

  Future<void> getRentFee() async {
    _rentFee = await PaymentDatabase().getRentFee();
    if (_rentFee != null) {
      log(_rentFee.toString());
      notifyListeners();
    }
  }

  Future<void> isPlayerPaid() async {
    _isPaid = await PaymentDatabase().isPlayerPaid();
  }
}
