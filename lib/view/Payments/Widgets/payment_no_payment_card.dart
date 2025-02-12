import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_left.dart';

class NoPaymentCard extends StatelessWidget {
  final bool isPaid;

  const NoPaymentCard({super.key, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isPaid ? Icons.check_circle_outline : Icons.verified_user,
                  color: Colors.grey[400], size: 24),
              const SizedBox(width: 8),
              Text(
                isPaid ? "No payments made yet" : "All payments are up to date",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}