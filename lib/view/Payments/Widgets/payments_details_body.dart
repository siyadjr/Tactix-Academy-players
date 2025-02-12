import 'package:flutter/material.dart';
import 'package:tactix_academy_players/controller/Controllers/payment_details_controller.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_section.dart';

class PaymentDetailsBody extends StatelessWidget {
  final PaymentDetailsController provider;
  const PaymentDetailsBody({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentSection(
                title: 'Paid Months',
                color: Colors.green,
                payments: provider.paidPayments,
                isPaid: true),
            const SizedBox(height: 24),
            PaymentSection(
                title: 'Unpaid Months',
                color: Colors.orange,
                payments: provider.unpaidPayments,
                isPaid: false),
          ],
        ),
      ),
    );
  }
}
