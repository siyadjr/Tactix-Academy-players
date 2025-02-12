import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tactix_academy_players/model/TeamDatabase/payment_database.dart';
import 'package:tactix_academy_players/model/payment_model.dart';

class PaymentDetailsController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<PaymentModel> _paidPayments = [];
  List<PaymentModel> get paidPayments => _paidPayments;
  
  List<PaymentModel> _unpaidPayments = [];  // Changed from List<String>
  List<PaymentModel> get unpaidPayments => _unpaidPayments;  // Changed from List<String>

  Future<void> getAllPlayerPaymentDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      _paidPayments.clear();
      _unpaidPayments.clear();

      List<String> allPayments = await PaymentDatabase().getPlayerAllPayments();
      
      for (var payment in allPayments) {
        log('Processing payment month: $payment');
        PaymentModel? fetchedPayment = await PaymentDatabase().checkPaidOrNot(payment);
        
        if (fetchedPayment != null) {
          _paidPayments.add(fetchedPayment);
        } else {
          // Create an unpaid PaymentModel instead of just storing the string
          _unpaidPayments.add(PaymentModel(
            name: payment,
            date: '',  // Empty since it's unpaid
            amount: '0',  // Or you could use the expected rent amount here
          ));
        }
      }

      // Sort payments by date if needed
      _paidPayments.sort((a, b) => b.date.compareTo(a.date));  // Most recent first
      
    } catch (e) {
      log("Error fetching payment details: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}