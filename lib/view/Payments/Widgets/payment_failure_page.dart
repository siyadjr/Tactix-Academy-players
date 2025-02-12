import 'package:flutter/material.dart';

class PaymentFailurePage extends StatelessWidget {
  const PaymentFailurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 100),
            Text('Payment Failed. Please Try Again.',
                style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
