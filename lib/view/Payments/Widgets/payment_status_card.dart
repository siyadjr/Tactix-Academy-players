import 'package:flutter/material.dart';
import 'package:tactix_academy_players/controller/Controllers/payment_provider.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_info_card.dart';

class PaymentStatusCard extends StatelessWidget {
  final PaymentProvider paymentProvider;
  const PaymentStatusCard({required this.paymentProvider, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (!paymentProvider.isActive) {
      return SizedBox(
        width: size.width * 0.9,
        child: InfoCard(
          title: 'All Caught Up!',
          message: 'No pending payments. Enjoy your training!',
          icon: Icons.celebration_rounded,
          color: Colors.green[700]!,
        ),
      );
    } else if (paymentProvider.isPaid) {
      return SizedBox(
        width: size.width * 0.9,
        child: InfoCard(
          title: 'Payment Received',
          message: 'Thank you for your timely payment!',
          icon: Icons.verified_user_rounded,
          color: Colors.blue[600]!,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
