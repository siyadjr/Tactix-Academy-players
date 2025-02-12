import 'package:flutter/material.dart';
import 'package:tactix_academy_players/view/Payments/player_payment_details.dart';

class PaymentHistoryButton extends StatelessWidget {
  const PaymentHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.history_rounded, color: Colors.blue[800]),
      label: const Text('Payment History',
          style: TextStyle(color: Colors.black87)),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const PlayerPaymentDetails()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        side: BorderSide(color: Colors.blue.shade100),
      ),
    );
  }
}
