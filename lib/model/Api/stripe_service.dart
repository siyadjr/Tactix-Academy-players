import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tactix_academy_players/core/Important/stripe.dart';
import 'package:tactix_academy_players/model/TeamDatabase/payment_database.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_failure_page.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_success_page.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment(String rentFee, BuildContext context) async {
    // Store navigator state at the beginning
    final navigatorState = Navigator.of(context);

    try {
      final amount = int.tryParse(rentFee);
      if (amount == null || amount <= 0) {
        log('Invalid amount');
        _showErrorDialog(navigatorState, "Invalid payment amount.");
        return;
      }

      String? paymentClientSecret = await _createPayment(amount, 'usd');
      if (paymentClientSecret == null) {
        log('Payment creation failed');
        _showErrorDialog(
            navigatorState, "Failed to create payment. Try again.");
        return;
      }

      log('Payment Intent Client Secret: $paymentClientSecret');

      // Initialize payment sheet
      try {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentClientSecret,
            merchantDisplayName: 'Tactix Academy',
            appearance: PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
                primary: Colors.blue[800],
                background: Colors.white,
                componentBackground: Colors.grey[100],
              ),
              shapes: const PaymentSheetShape(
                borderRadius: 12.0,
                shadow: PaymentSheetShadowParams(color: Colors.black),
              ),
            ),
          ),
        );
      } catch (e) {
        log('Error initializing payment sheet: $e');
        _showErrorDialog(navigatorState, "Payment initialization failed.");
        return;
      }

      await _processPayment(amount, navigatorState);
    } catch (e) {
      log('Error in makePayment: $e');
      _showErrorDialog(navigatorState, "An unexpected error occurred.");
    }
  }

  Future<void> _processPayment(int amount, NavigatorState navigator) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await PaymentDatabase().payRent(amount.toString());

      navigator.pushReplacement(
        MaterialPageRoute(
            builder: (ctx) => PaymentSuccessPage(
                  rentFee: amount.toString(),
                )),
      );
    } on StripeException catch (e) {
      log('Stripe Error: ${e.error.localizedMessage}');

      // Show error dialog before navigation
      await _showErrorDialog(
          navigator, "Payment failed: ${e.error.localizedMessage}");

      navigator.pushReplacement(
        MaterialPageRoute(builder: (ctx) => const PaymentFailurePage()),
      );
    } catch (e) {
      log('Error in _processPayment: $e');
      _showErrorDialog(
          navigator, "An error occurred while processing payment.");
    }
  }

  Future<String?> _createPayment(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: {
          'amount': _calculateAmount(amount),
          'currency': currency,
          'payment_method_types[]': 'card',
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Payment Intent Created: ${response.data}');
        return response.data['client_secret'];
      } else {
        log('Failed to create payment: ${response.statusCode} - ${response.data}');
      }
    } on DioException catch (e) {
      log('Dio Error in _createPayment: ${e.message}');
      log('Response: ${e.response?.data}');
    } catch (e) {
      log('Error in _createPayment: $e');
    }
    return null;
  }

  String _calculateAmount(int amount) {
    return (amount * 100).toString(); // Convert to cents
  }

  Future<void> _showErrorDialog(
      NavigatorState navigator, String message) async {
    return showDialog(
      context: navigator.context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red[700]),
            const SizedBox(width: 10),
            const Text(
              "Payment Error",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue[800],
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
