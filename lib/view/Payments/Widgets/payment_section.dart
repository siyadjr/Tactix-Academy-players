import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_left.dart';
import 'package:tactix_academy_players/model/payment_model.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_card.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_no_payment_card.dart';
import 'package:tactix_academy_players/view/Payments/player_payment_details.dart';

class PaymentSection extends StatelessWidget {
  final String title;
  final Color color;
  final List<PaymentModel> payments;
  final bool isPaid;

  const PaymentSection(
      {super.key,
      required this.title,
      required this.color,
      required this.payments,
      required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: color),
          ),
          const SizedBox(height: 12),
          payments.isEmpty
              ? NoPaymentCard(isPaid: isPaid)
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    return PaymentCard(
                        payment: payments[index], isPaid: isPaid);
                  },
                ),
        ],
      ),
    );
  }
}