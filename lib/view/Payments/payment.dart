import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:tactix_academy_players/controller/Controllers/payment_provider.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/custom_scaffold.dart';
import 'package:tactix_academy_players/core/Reusable%20Widgets/loading_indicator.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/current_payment_card.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_history_button.dart';
import 'package:tactix_academy_players/view/Payments/Widgets/payment_status_card.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.checkRentStatus();
    });

    return CustomScaffold(
      appBar: AppBar(
        title: const Text(
          'Payments',
          style: TextStyle(
            color: defaultTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
       
        elevation: 0,
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, child) {
          if (paymentProvider.isloading) {
            return const Center(child: LoadingIndicator());
          }
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInDown(
                    child: PaymentStatusCard(paymentProvider: paymentProvider),
                  ),
                  if (paymentProvider.isActive && !paymentProvider.isPaid)
                    FadeInLeft(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: CurrentPaymentCard(
                            paymentProvider: paymentProvider),
                      ),
                    ),
                  SizedBox(height: size.height * 0.03),
                  FadeInUp(
                    child: const PaymentHistoryButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}




