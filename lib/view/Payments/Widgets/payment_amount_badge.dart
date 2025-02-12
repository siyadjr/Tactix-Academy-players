import 'package:flutter/material.dart';

class AmountBadge extends StatelessWidget {
  final String amount;

  const AmountBadge({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Text(
        "₹$amount",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
            fontSize: 14),
      ),
    );
  }
}