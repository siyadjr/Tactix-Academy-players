import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/controller/Controllers/payment_details_controller.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/model/payment_model.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payments_details_body.dart';

class PlayerPaymentDetails extends StatelessWidget {
  const PlayerPaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PaymentDetailsController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getAllPlayerPaymentDetails();
    });

    return CustomScaffold(
      appBar: AppBar(
        title: const Text(
          'Payment History',
          style:
              TextStyle(color: defaultTextColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<PaymentDetailsController>(
        builder: (context, provider, child) {
          return provider.isLoading
              ? const Center(child: LoadingIndicator())
              : PaymentDetailsBody(provider: provider);
        },
      ),
    );
  }
}
