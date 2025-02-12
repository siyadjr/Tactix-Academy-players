import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/bouncing_entrances/bounce_in_up.dart';
import 'package:tactix_academy_players/controller/Controllers/payment_provider.dart';
import 'package:tactix_academy_players/model/Api/stripe_service.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_detail.dart';
import 'package:tactix_academy_players/view/Payments/payment.dart';

class CurrentPaymentCard extends StatelessWidget {
  final PaymentProvider paymentProvider;
  const CurrentPaymentCard({required this.paymentProvider, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();
    final dueDate = '${now.day}/${now.month}/${now.year}';

    return Container(
      width: size.width * 0.9,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.blue[800]!, Colors.purple[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PaymentDetail(
            label: 'Due Date',
            value: dueDate,
            icon: Icons.calendar_today_rounded,
          ),
          PaymentDetail(
            label: 'Amount Due',
            value: '₹${paymentProvider.rentFee ?? "0"}',
            icon: Icons.currency_rupee_rounded,
          ),
          SizedBox(height: size.height * 0.02),
          BounceInUp(
            child: ElevatedButton(
              onPressed: () async {
                StripeService.instance
                    .makePayment(paymentProvider.rentFee!, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue[800],
                minimumSize: Size(size.width * 0.7, size.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
              ),
              child: const Text(
                'Pay Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

