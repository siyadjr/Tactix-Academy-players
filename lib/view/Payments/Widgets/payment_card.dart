import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in_left.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/functions.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/model/payment_model.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_amount_badge.dart';

class PaymentCard extends StatelessWidget {
  final PaymentModel payment;
  final bool isPaid;

  const PaymentCard({super.key, required this.payment, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(isPaid ? Icons.check_circle : Icons.warning_rounded,
              color: isPaid ? Colors.green[600] : Colors.orange[600]),
          title: Text(formatMonthYear(payment.name),
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          subtitle: Text(
            isPaid ? formatPaymentDate(payment.date) : "Payment pending",
            style: TextStyle(color: isPaid ? Colors.grey[600] : Colors.orange),
          ),
          trailing: isPaid
              ? AmountBadge(amount: payment.amount)
              : CircleAvatar(
                  backgroundColor: Colors.orange[50],
                  radius: 18,
                  child: IconButton(
                    onPressed: () {
                      _showDialogue(context);
                    },
                    icon: Icon(Icons.arrow_forward_ios_rounded,
                        size: 16, color: Colors.orange[600]),
                  )),
        ),
      ),
    );
  }

  void _showDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: mainBackground,
          title: const Text(
            "Payment Reminder",
            style: TextStyle(color: defaultTextColor),
          ),
          content: const Text(
              "Please contact your manager regarding the pending payment."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
